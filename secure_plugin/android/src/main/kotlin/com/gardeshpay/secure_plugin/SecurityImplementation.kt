package com.gardeshpay.secure_plugin

import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.Build
import android.security.KeyPairGeneratorSpec
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyPermanentlyInvalidatedException
import android.security.keystore.KeyProperties
import android.security.keystore.UserNotAuthenticatedException
import android.util.Base64
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatDelegate
import androidx.biometric.BiometricManager.Authenticators.*
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.core.os.LocaleListCompat
import androidx.fragment.app.FragmentActivity
import com.tom_roush.pdfbox.pdmodel.PDDocument
import com.tom_roush.pdfbox.pdmodel.interactive.digitalsignature.PDSignature
import com.tom_roush.pdfbox.pdmodel.interactive.digitalsignature.SignatureInterface
import com.tom_roush.pdfbox.pdmodel.interactive.digitalsignature.SignatureOptions
import com.tom_roush.pdfbox.pdmodel.interactive.digitalsignature.visible.PDVisibleSigProperties
import com.tom_roush.pdfbox.pdmodel.interactive.digitalsignature.visible.PDVisibleSignDesigner
import org.bouncycastle.cert.X509CertificateHolder
import org.bouncycastle.cert.jcajce.JcaCertStore
import org.bouncycastle.cms.CMSSignedDataGenerator
import org.bouncycastle.cms.jcajce.JcaSignerInfoGeneratorBuilder
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder
import org.bouncycastle.operator.jcajce.JcaDigestCalculatorProviderBuilder
import java.io.*
import java.math.BigInteger
import java.security.*
import java.security.cert.Certificate
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.security.spec.AlgorithmParameterSpec
import java.util.*
import java.util.concurrent.Executor
import javax.security.auth.x500.X500Principal


class SecurityImplementation {
  companion object {
    private var mCacheDir: File? = null
    private var mSignatureNameFamily: String? = null
    private var mSignatureHeight: Int = 0
    private var mSignatureWidth: Int = 0
    private var mSignatureY: Int = 0
    private var mSignatureX: Int = 0
    private var mSignaturePage: Int = 1
    private lateinit var mSignatureBase64: String
    private lateinit var mPdfBase64: String
    private var mReason: String? = null
    private var mLocation: String? = null
    private var mName: String? = null
    private lateinit var mCert: String
    private lateinit var signPdfListener: SignPdfListener
    private lateinit var bytesData: ByteArray
    private var isText: Boolean = true
    private const val ANDROID_KEYSTORE = "AndroidKeyStore"
    private lateinit var executor: Executor
    private lateinit var biometricPrompt: BiometricPrompt
    private lateinit var promptInfo: BiometricPrompt.PromptInfo
    private lateinit var plainText: String
    private lateinit var listener: SignDataListener
    private lateinit var keyAlias: String
    private var isSignPdf: Boolean = false
    private lateinit var resources: Resources
      fun isEnroll(phoneNumber: String): ResponseDataModel {
      this.keyAlias = phoneNumber
          val responseDataModel = ResponseDataModel()
      val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }
      var publicKey: PublicKey? = null
      var privateKey: PrivateKey? = null
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        if (keyStore.containsAlias(keyAlias)) {
          publicKey = keyStore.getCertificate(keyAlias).publicKey
          privateKey = keyStore.getKey(keyAlias, null) as PrivateKey
        } else {
            responseDataModel.statusCode = 404
            responseDataModel.isSuccess = false
            responseDataModel.data = "false"
            responseDataModel.message = "Key not found"
        }
      } else {
        if (keyStore.containsAlias(keyAlias)) {
          val asymmetricKey = keyStore.getEntry(keyAlias, null) as KeyStore.PrivateKeyEntry
          publicKey = asymmetricKey.certificate.publicKey
          privateKey = asymmetricKey.privateKey
        } else {
            responseDataModel.statusCode = 404
            responseDataModel.isSuccess = false
            responseDataModel.data = "false"
            responseDataModel.message = "Key not found"
        }
      }
      val isEnrollResult = privateKey != null && publicKey != null
      if (isEnrollResult) {
          responseDataModel.statusCode = 200
          responseDataModel.isSuccess = true
          responseDataModel.data = "true"
          responseDataModel.message = "Key found"
      } else {
          responseDataModel.statusCode = 500
          responseDataModel.isSuccess = false
          responseDataModel.data = "false"
          responseDataModel.message = "Key not found"
      }
          return responseDataModel
    }

    fun generateKey(
      context: Context,
      phoneNumber: String,
      nameEnglish: String
    ): ResponseDataModel {
      resources =
        context.resources
      val initialLocale = Locale.getDefault()
      setAppLocale(Locale.ENGLISH, Locale.ENGLISH.toLanguageTag())
      this.keyAlias = phoneNumber
        val responseDataModel = ResponseDataModel()
      if (isEnroll(keyAlias).isSuccess == true) {
        val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
          load(null)
        }
        val publicKey: PublicKey? = keyStore.getCertificate(keyAlias)?.publicKey
        val bytePublicKey: ByteArray = publicKey!!.encoded
          responseDataModel.message = "Key generated"
          responseDataModel.data = Base64.encodeToString(bytePublicKey, Base64.NO_WRAP)
          responseDataModel.isSuccess = true
          responseDataModel.statusCode = 200
        setAppLocale(initialLocale, initialLocale.toLanguageTag())
          return responseDataModel
      }
      //We create the start and expiry date for the key
      val start = Calendar.getInstance(Locale.ENGLISH)
      val end = Calendar.getInstance(Locale.ENGLISH)
      end.add(Calendar.YEAR, 1)

      val kpGenerator: KeyPairGenerator =
        KeyPairGenerator.getInstance("RSA", ANDROID_KEYSTORE)

      val spec: AlgorithmParameterSpec

      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
        spec = makeAlgorithmParameterSpecLegacy(context, start, end, nameEnglish)
      } else {
        val builder = KeyGenParameterSpec.Builder(
          keyAlias,
          KeyProperties.PURPOSE_DECRYPT or KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY
        )
        builder.setCertificateSubject(X500Principal("CN=$nameEnglish"))
        builder.setDigests(KeyProperties.DIGEST_SHA256)
        builder.setBlockModes(KeyProperties.BLOCK_MODE_ECB)
        builder.setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_RSA_PKCS1)
        builder.setSignaturePaddings(KeyProperties.SIGNATURE_PADDING_RSA_PKCS1)
        builder.setCertificateSerialNumber(BigInteger.valueOf(1))
        builder.setCertificateNotBefore(start.time)
        builder.setCertificateNotAfter(end.time)
//        builder.setKeyValidityStart(start.time)
//        builder.setKeyValidityEnd(end.time)
          builder.setKeySize(2048)
        // TODO check samsung user not authentication exception
        builder.setUserAuthenticationRequired(false)
//        if (Build.VERSION.SDK_INT >= 30) {
//          builder.setUserAuthenticationParameters(120, KeyProperties.AUTH_BIOMETRIC_STRONG);
//        } else {
//          builder.setUserAuthenticationValidityDurationSeconds(120);
//        }
//        if (Build.VERSION.SDK_INT >= 24) {
//          builder.setInvalidatedByBiometricEnrollment(false)
//        }
        spec = builder.build()
      }

      kpGenerator.initialize(spec)
      kpGenerator.generateKeyPair()
      val keyPair: KeyPair = kpGenerator.genKeyPair()
      val bytePublicKey: ByteArray = keyPair.public.encoded
        responseDataModel.message = "Key generated"
        responseDataModel.data = Base64.encodeToString(bytePublicKey, Base64.NO_WRAP)
        responseDataModel.isSuccess = true
        responseDataModel.statusCode = 200
      setAppLocale(initialLocale, initialLocale.toLanguageTag())
        return responseDataModel
    }

    @Suppress("DEPRECATION")
    private fun makeAlgorithmParameterSpecLegacy(
      context: Context,
      start: Calendar,
      end: Calendar,
      nameEnglish: String
    ): AlgorithmParameterSpec {
      return KeyPairGeneratorSpec.Builder(context)
        .setAlias(keyAlias)
        .setSubject(X500Principal("CN=$nameEnglish"))
        .setSerialNumber(BigInteger.valueOf(1))
        .setStartDate(start.time)
        .setEndDate(end.time)
        .setKeySize(1024)
        //.setEncryptionRequired()
        .build()
    }

    private fun setAppLocale(locale: Locale, tags: String) {
      val configuration: Configuration = resources.configuration
      Locale.setDefault(locale)
      configuration.setLocale(locale)
      val appLocale: LocaleListCompat = LocaleListCompat.forLanguageTags(tags)
      AppCompatDelegate.setApplicationLocales(appLocale)
    }

    fun signText(
      plainText: String,
      activity: Activity,
      context: Context,
      phoneNumber: String,
      listener: SignDataListener
    ) {
      this.keyAlias = phoneNumber
      this.plainText = plainText
      this.listener = listener
      this.isText = true
      isSignPdf = false
      initBiometricPrompt(activity, context)
      showAuthenticationScreen()
    }

    private fun initBiometricPrompt(activity: Activity, context: Context) {
      executor = ContextCompat.getMainExecutor(context)
      biometricPrompt = BiometricPrompt(activity as FragmentActivity, executor,
        object : BiometricPrompt.AuthenticationCallback() {
          override fun onAuthenticationError(
            errorCode: Int,
            errString: CharSequence
          ) {
            super.onAuthenticationError(errorCode, errString)
              val responseDataModel = ResponseDataModel()
              responseDataModel.statusCode = errorCode
              responseDataModel.data = null
              responseDataModel.isSuccess = false
              responseDataModel.message = errString.toString()
            if (isSignPdf) {
                signPdfListener.signedPdf(responseDataModel)
            } else {
                listener.signedData(responseDataModel)
            }
          }

          override fun onAuthenticationSucceeded(
            result: BiometricPrompt.AuthenticationResult
          ) {
            super.onAuthenticationSucceeded(result)
            if (isSignPdf) {
              signPdf()
            } else {
              if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                signTextBelow23()
              } else {
                signTextAbove23()
              }
            }
          }

          override fun onAuthenticationFailed() {
            super.onAuthenticationFailed()
            Log.e("SecurePlugin", "Authentication failed")
          }
        })
      promptInfo = BiometricPrompt.PromptInfo.Builder()
        .setTitle("امضا دیجیتال")
        .setSubtitle("لطفا جهت تایید از اثر انگشت یا رمز ورود خود را استفاده نمایید")
        .setAllowedAuthenticators(BIOMETRIC_STRONG or DEVICE_CREDENTIAL or BIOMETRIC_WEAK)
        .build()

    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun signTextAbove23() {
        val responseDataModel = ResponseDataModel()
      try {
        //We get the Keystore instance
        val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
          load(null)
        }

        //Retrieves the private key from the keystore
        val privateKey: PrivateKey = keyStore.getKey(keyAlias, null) as PrivateKey

        //We sign the data with the private key. We use RSA algorithm along SHA-256 digest algorithm
        val signature: ByteArray? = if (isText) {
          Signature.getInstance("SHA256withRSA").run {
            initSign(privateKey)
            update(plainText.toByteArray())
            sign()
          }
        } else {
          Signature.getInstance("SHA256withRSA").run {
            initSign(privateKey)
            update(bytesData)
            sign()
          }
        }

        if (signature != null) {
          val signatureResult = Base64.encodeToString(signature, Base64.NO_WRAP)
            responseDataModel.message = "Data signed"
            responseDataModel.statusCode = 200
            responseDataModel.data = signatureResult
            responseDataModel.isSuccess = true
        }

      } catch (e: UserNotAuthenticatedException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: KeyPermanentlyInvalidatedException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: InvalidKeyException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 402
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: SignatureException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: Exception) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      }
        listener.signedData(responseDataModel)
    }

    private fun signTextBelow23() {
      val ks: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }
        val responseDataModel = ResponseDataModel()
      try {
        //Retrieves the private key from the keystore
        val privateKey: PrivateKey = ks.getKey(keyAlias, null) as PrivateKey

        //We sign the data with the private key. We use RSA algorithm along SHA-256 digest algorithm
        val signature: ByteArray = if (isText) {
          Signature.getInstance("SHA256withRSA").run {
            initSign(privateKey)
            update(plainText.toByteArray())
            sign()
          }
        } else {
          Signature.getInstance("SHA256withRSA").run {
            initSign(privateKey)
            update(bytesData)
            sign()
          }
        }
        //We encode and store in a variable the value of the signature
        val signatureResult = Base64.encodeToString(signature, Base64.NO_WRAP)
          responseDataModel.message = "Data signed"
          responseDataModel.statusCode = 200
          responseDataModel.data = signatureResult
          responseDataModel.isSuccess = true
      } catch (e: NoSuchAlgorithmException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: InvalidKeyException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 402
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: SignatureException) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      } catch (e: java.lang.Exception) {
          responseDataModel.message = e.message
          responseDataModel.statusCode = 500
          responseDataModel.data = null
          responseDataModel.isSuccess = false
      }
        listener.signedData(responseDataModel)
    }

    private fun showAuthenticationScreen() {
      biometricPrompt.authenticate(promptInfo)
    }

      fun removeKey(phoneNumber: String): ResponseDataModel {
      this.keyAlias = phoneNumber
      val ks: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }
          val responseDataModel = ResponseDataModel()
      if (ks.getKey(keyAlias, null) != null) {
        ks.deleteEntry(keyAlias)
          responseDataModel.isSuccess = true
          responseDataModel.data = null
          responseDataModel.statusCode = 200
          responseDataModel.message = "Key removed successfully"
      } else {
          responseDataModel.isSuccess = false
          responseDataModel.data = null
          responseDataModel.statusCode = 404
          responseDataModel.message = "Key not found"
      }
          return responseDataModel
    }

      fun verifyData(plainText: String, signedText: String, phoneNumber: String): ResponseDataModel {
      this.keyAlias = phoneNumber
          val responseDataModel = ResponseDataModel()
      val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }

      val certificate: Certificate? = keyStore.getCertificate(keyAlias)

      if (certificate != null) {
        val signature: ByteArray = Base64.decode(signedText, Base64.DEFAULT)

        //We check if the signature is valid. We use RSA algorithm along SHA-256 digest algorithm
        val isValid: Boolean = Signature.getInstance("SHA256withRSA").run {
          initVerify(certificate)
          update(plainText.toByteArray())
          verify(signature)
        }
          responseDataModel.isSuccess = isValid
          responseDataModel.data = null
        if (isValid) {
            responseDataModel.statusCode = 200
            responseDataModel.message = "Data is verify"
        } else {
            responseDataModel.message = "Data is NOT verify"
            responseDataModel.statusCode = 500
        }
      } else {
          responseDataModel.message = "Certificate not found"
          responseDataModel.isSuccess = false
          responseDataModel.data = null
          responseDataModel.statusCode = 500
      }
          return responseDataModel
    }

      fun verifyBytes(bytesData: ByteArray, signedText: String, phoneNumber: String): ResponseDataModel {
      this.keyAlias = phoneNumber
          val responseDataModel = ResponseDataModel()
      val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }

      val certificate: Certificate? = keyStore.getCertificate(keyAlias)

      if (certificate != null) {
        val signature: ByteArray = Base64.decode(signedText, Base64.DEFAULT)

        //We check if the signature is valid. We use RSA algorithm along SHA-256 digest algorithm
        val isValid: Boolean = Signature.getInstance("SHA256withRSA").run {
          initVerify(certificate)
          update(bytesData)
          verify(signature)
        }
          responseDataModel.isSuccess = isValid
          responseDataModel.data = null
        if (isValid) {
            responseDataModel.statusCode = 200
            responseDataModel.message = "Data is verify"
        } else {
            responseDataModel.message = "Data is NOT verify"
            responseDataModel.statusCode = 500
        }
      } else {
          responseDataModel.message = "Certificate not found"
          responseDataModel.isSuccess = false
          responseDataModel.data = null
          responseDataModel.statusCode = 500
      }
          return responseDataModel
    }

    fun signBytes(
      bytesData: ByteArray,
      activity: Activity,
      context: Context,
      phoneNumber: String,
      listener: SignDataListener
    ) {
      this.keyAlias = phoneNumber
      this.bytesData = bytesData
      this.listener = listener
      this.isText = false
      isSignPdf = false
      initBiometricPrompt(activity, context)
      showAuthenticationScreen()
    }

    fun newSignPdf(
      phoneNumber: String,
      pdfBase64: String,
      signatureBase64: String,
      signatureX: Int,
      signatureY: Int,
      signatureWidth: Int,
      signatureHeight: Int,
      signaturePage: Int,
      cert: String,
      name: String?,
      location: String?,
      reason: String?,
      signatureNameFamily: String?,
      activity: Activity,
      context: Context,
      listener: SignPdfListener
    ) {
      isSignPdf = true
      keyAlias = phoneNumber
      signPdfListener = listener
      mCert = cert
      mPdfBase64 = pdfBase64
      mSignatureBase64 = signatureBase64
      mSignatureX = signatureX
      mSignatureY = signatureY
      mSignatureWidth = signatureWidth
      mSignatureHeight = signatureHeight
      mSignaturePage = signaturePage
      mName = name
      mLocation = location
      mReason = reason
      mSignatureNameFamily = signatureNameFamily
      mCacheDir = context.cacheDir
      resources = context.resources
      initBiometricPrompt(activity, context)
      showAuthenticationScreen()
    }

    private fun signPdf(
    ) {
      val initialLocale = Locale.getDefault()
      setAppLocale(Locale.ENGLISH, Locale.ENGLISH.toLanguageTag())
      val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
        load(null)
      }
      var chain = keyStore.getCertificateChain(keyAlias)
      if (mCert.isNotEmpty()) {
        val certString = "-----BEGIN CERTIFICATE-----\n" +
            mCert + "\n-----END CERTIFICATE-----"
        val libCertByte = certString.toByteArray(charset("UTF8"))
        val inputStream = ByteArrayInputStream(libCertByte)
        val x509 = CertificateFactory.getInstance("X.509")
          .generateCertificate(inputStream)
        val listCert = arrayOf(x509)
        chain = listCert
      }
      mSignaturePage += 1
      val privateKey = keyStore.getKey(keyAlias, null) as PrivateKey
      val pdfBase64DecodedBytes = Base64.decode(mPdfBase64, Base64.DEFAULT)
      val signatureBase64DecodedBytes = Base64.decode(mSignatureBase64, Base64.DEFAULT)
      val document: PDDocument = PDDocument.load(pdfBase64DecodedBytes)
      val visualSignEnabled = PDVisibleSigProperties()
        .signerName(mName)
        .signerLocation(mLocation)
        .signatureReason(mReason)
        .page(mSignaturePage)
        .visualSignEnabled(true)
      val file = File(mCacheDir!!.path + "signature.png")
      file.writeBytes(signatureBase64DecodedBytes)
      val fileInputStream = FileInputStream(file)
      visualSignEnabled.pdVisibleSignature = PDVisibleSignDesigner(
        document, fileInputStream,
        mSignaturePage
      ).xAxis(mSignatureX.toFloat()).yAxis(mSignatureY.toFloat())
        .height(mSignatureHeight.toFloat())
        .width(mSignatureWidth.toFloat())
        .adjustForRotation()
      visualSignEnabled.buildSignature()

      val pDSignature = PDSignature()
      pDSignature.setFilter(PDSignature.FILTER_ADOBE_PPKLITE)
      pDSignature.setSubFilter(PDSignature.SUBFILTER_ADBE_PKCS7_DETACHED)
      pDSignature.name = mName ?: "Test User"
      pDSignature.location = mLocation ?: "Tehran, Tehran"
      pDSignature.reason = mReason ?: "Testing"
      pDSignature.signDate = Calendar.getInstance(Locale.ENGLISH)
      val signatureOptions = SignatureOptions()
      signatureOptions.preferredSignatureSize = 18944
      if (visualSignEnabled.isVisualSignEnabled) {
        signatureOptions.setVisualSignature(visualSignEnabled.visibleSignature)
        signatureOptions.page = visualSignEnabled.page - 1
      }
      document.addSignature(pDSignature, object : SignatureInterface {
        override fun sign(content: InputStream?): ByteArray {
          try {
            val cMSSignedDataGenerator = CMSSignedDataGenerator()
            cMSSignedDataGenerator.addSignerInfoGenerator(
              JcaSignerInfoGeneratorBuilder(
                JcaDigestCalculatorProviderBuilder().build()
              ).build(
                JcaContentSignerBuilder("SHA256WithRSA").build(privateKey),
                chain!![0] as X509Certificate
              )
            )
            val list = arrayListOf<X509CertificateHolder>()
            for (certItem in chain) {
              val holder = X509CertificateHolder(certItem.encoded)
              list.add(holder)
            }
            val certs = JcaCertStore(list)
            cMSSignedDataGenerator.addCertificates(certs)
            return cMSSignedDataGenerator.generate(
              content?.let { CMSProcessableInputStream(it) },
              false
            ).encoded
          } catch (e: java.lang.Exception) {
            e.printStackTrace()
              val responseDataModel = ResponseDataModel()
              responseDataModel.data = null
              responseDataModel.message = e.message
              responseDataModel.isSuccess = false
              responseDataModel.statusCode = 500
              signPdfListener.signedPdf(responseDataModel)
            setAppLocale(initialLocale, initialLocale.toLanguageTag())
            throw RuntimeException("Problem while preparing signature:" + e.message)
          }
        }
      }, signatureOptions)
      val byteArrayOutputStream = ByteArrayOutputStream()
      document.saveIncremental(byteArrayOutputStream)
      document.close()
        val responseDataModel = ResponseDataModel()
        responseDataModel.data = Base64.encodeToString(byteArrayOutputStream.toByteArray(), Base64.NO_WRAP)
        responseDataModel.message = "success"
        responseDataModel.isSuccess = true
        responseDataModel.statusCode = 200
        signPdfListener.signedPdf(responseDataModel)
      setAppLocale(initialLocale, initialLocale.toLanguageTag())
    }

      fun getPublicKey(phoneNumber: String): ResponseDataModel {
      this.keyAlias = phoneNumber
          val responseDataModel = ResponseDataModel()
      if (isEnroll(keyAlias).isSuccess == true) {
        val keyStore: KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply {
          load(null)
        }
        val publicKey: PublicKey? = keyStore.getCertificate(keyAlias)?.publicKey
        val bytePublicKey: ByteArray = publicKey!!.encoded
          responseDataModel.message = "Key generated"
          responseDataModel.data = Base64.encodeToString(bytePublicKey, Base64.NO_WRAP)
          responseDataModel.isSuccess = true
          responseDataModel.statusCode = 200
          return responseDataModel
      } else {
          responseDataModel.message = "Key not found"
          responseDataModel.data = null
          responseDataModel.isSuccess = false
          responseDataModel.statusCode = 404
          return responseDataModel
      }
    }
  }
}