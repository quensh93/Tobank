import fs from 'fs/promises'
import path from 'path'
import axios from 'axios'

const API_URL = 'http://192.168.179.21:8101/api/configurations/v1.0/configs/add'
const PAGES_DIR = path.join(process.cwd(), 'pages')

async function readJson(filePath) {
  const content = await fs.readFile(filePath, 'utf-8')
  return JSON.parse(content)
}

async function sendRequest(pageName, value, config) {
  const payload = {
    key: config.key,
    build: 1,
    parentId: "7b69a57d-05b9-459a-8cf6-1a87177402a9",
    title: config.title,
    dimension: { app: "mobile" },
    value,
    schema: {}
  }

  try {
    const res = await axios.post(API_URL, payload, {
      headers: { 'Content-Type': 'application/json' }
    })

    return {
      page: pageName,
      success: true,
      status: res.status
    }
  } catch (err) {
    return {
      page: pageName,
      success: false,
      error: err.response?.data || err.message
    }
  }
}

async function run() {
  console.log('🚀 Service started...\n')

  const files = await fs.readdir(PAGES_DIR)

  // فقط page*.json (نه page*-config.json)
  const pageFiles = files.filter(
    f => f.endsWith('.json') && !f.endsWith('-config.json')
  )

  const results = []

  for (const pageFile of pageFiles) {
    const pageName = path.parse(pageFile).name
    const pagePath = path.join(PAGES_DIR, pageFile)
    const configPath = path.join(PAGES_DIR, `${pageName}-config.json`)

    console.log(`📄 Processing ${pageName}`)

    try {
      const value = await readJson(pagePath)
      const config = await readJson(configPath)

      const result = await sendRequest(pageName, value, config)
      results.push(result)

      if (result.success) {
        console.log(`✅ ${pageName} sent successfully`, `${result}`)
      } else {
        console.log(`❌ ${pageName} failed`, result.error)
      }
    } catch (err) {
      results.push({
        page: pageName,
        success: false,
        error: `Config or page file error: ${err.message}`
      })

      console.log(`🔥 ${pageName} error reading files`)
    }

    console.log('---------------------------')
  }

  console.log('\n📊 Final Result:')
  console.table(results)

}

run().catch(err => {
  console.error('🔥 Fatal Error:', err)
})