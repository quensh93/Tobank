# flows/promissory_real/json/promissory_real_sign.json

Source: lib/stac/tobank/flows/promissory_real/json/promissory_real_sign.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "actionType": "sequence",
    "actions": [
      {
        "actionType": "setValue",
        "values": [
          {
            "key": "signScreenLoading",
            "value": true
          },
          {
            "key": "signScreenError",
            "value": false
          },
          {
            "key": "signScreenLoaded",
            "value": false
          }
        ]
      },
      {
        "actionType": "setValue",
        "key": "isSigning",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "signPage",
        "value": "1"
      },
      {
        "actionType": "setValue",
        "key": "signX",
        "value": "100"
      },
      {
        "actionType": "setValue",
        "key": "signY",
        "value": "200"
      },
      {
        "actionType": "setValue",
        "key": "signWidth",
        "value": "150"
      },
      {
        "actionType": "setValue",
        "key": "signHeight",
        "value": "50"
      },
      {
        "actionType": "setValue",
        "key": "form.promissory_request_id",
        "value": "{{form.promissory_request_id ?? \"REQ-\" + now()}}"
      },
      {
        "actionType": "networkRequest",
        "url": "http://192.168.107.22:8280/api/digitalbanking/files/v1.0/{{form.unsigned_pdf_id}}/download/base64",
        "method": "get",
        "headers": {
          "accept": "application/json",
          "content-type": "application/json",
          "app-platform": "android",
          "app-store": "application/json",
          "app-version": "456",
          "device-uuid": "5109ab4c-77ca-4f0c-9858-da4df58031d2",
          "serviceauthorization": "Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==",
          "authorization": "{{auth.accessToken}}"
        },
        "results": [
          {
            "statusCode": 200,
            "action": {
              "actionType": "setValue",
              "values": [
                {
                  "key": "form.unsigned_pdf",
                  "value": "{{data.data.base64}}"
                },
                {
                  "key": "signScreenLoading",
                  "value": false
                },
                {
                  "key": "signScreenError",
                  "value": false
                },
                {
                  "key": "signScreenLoaded",
                  "value": true
                }
              ]
            }
          },
          {
            "statusCode": -1,
            "action": {
              "actionType": "setValue",
              "values": [
                {
                  "key": "signScreenLoading",
                  "value": false
                },
                {
                  "key": "signScreenError",
                  "value": true
                },
                {
                  "key": "signScreenLoaded",
                  "value": false
                }
              ]
            }
          }
        ]
      }
    ]
  },
  "child": {
    "appBar": {
      "leading": {
        "onPressed": {
          "navigationStyle": "pop",
          "actionType": "navigate"
        },
        "icon": {
          "src": "assets/icons/ic_right_arrow.svg",
          "imageType": "asset",
          "color": "{{appColors.current.text.title}}",
          "width": 24.0,
          "height": 24.0,
          "type": "image"
        },
        "type": "iconButton"
      },
      "title": {
        "data": "{{appStrings.promissory.signTitle}}",
        "style": {
          "type": "alias",
          "value": "{{appStyles.appbarStyle}}"
        },
        "textDirection": "rtl",
        "type": "text"
      },
      "centerTitle": true,
      "type": "appBar"
    },
    "body": {
      "crossAxisAlignment": "stretch",
      "textDirection": "rtl",
      "children": [
        {
          "child": {
            "type": "stack",
            "children": [
              {
                "type": "registryReactive",
                "registryKey": "signScreenLoading",
                "child": {
                  "type": "visibility",
                  "visible": "{{signScreenLoading}}",
                  "child": {
                    "type": "center",
                    "child": {
                      "type": "column",
                      "mainAxisAlignment": "center",
                      "children": [
                        {
                          "type": "circularProgressIndicator",
                          "color": "{{appColors.current.primary.color}}"
                        },
                        {
                          "type": "sizedBox",
                          "height": 16
                        },
                        {
                          "type": "text",
                          "data": "{{appStrings.promissory.loadingText}}",
                          "textDirection": "rtl",
                          "style": {
                            "type": "custom",
                            "fontSize": 14,
                            "color": "{{appColors.current.text.subtitle}}"
                          }
                        }
                      ]
                    }
                  }
                }
              },
              {
                "type": "registryReactive",
                "registryKey": "signScreenError",
                "child": {
                  "type": "visibility",
                  "visible": "{{signScreenError}}",
                  "child": {
                    "type": "center",
                    "child": {
                      "type": "column",
                      "mainAxisAlignment": "center",
                      "children": [
                        {
                          "type": "image",
                          "src": "assets/icons/ic_info.svg",
                          "imageType": "asset",
                          "width": 48,
                          "height": 48,
                          "color": "#D32F2F"
                        },
                        {
                          "type": "sizedBox",
                          "height": 16
                        },
                        {
                          "type": "text",
                          "data": "{{appStrings.promissory.serverConnectionError}}",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 16,
                            "fontWeight": "bold",
                            "color": "{{appColors.current.text.title}}"
                          }
                        },
                        {
                          "type": "sizedBox",
                          "height": 24
                        },
                        {
                          "type": "container",
                          "padding": {
                            "top": 0,
                            "right": 16,
                            "bottom": 16,
                            "left": 16
                          },
                          "child": {
                            "type": "elevatedButton",
                            "onPressed": {
                              "actionType": "pop"
                            },
                            "style": {
                              "backgroundColor": "{{appColors.current.primary.color}}",
                              "foregroundColor": "{{appColors.current.primary.onPrimary}}",
                              "shape": {
                                "type": "roundedRectangle",
                                "borderRadius": {
                                  "type": "all",
                                  "radius": 12
                                }
                              }
                            },
                            "child": {
                              "type": "text",
                              "data": "Ø¨Ø§Ø²Ú¯Ø´Øª",
                              "style": {
                                "type": "custom",
                                "fontSize": 16,
                                "fontWeight": "bold"
                              }
                            }
                          }
                        }
                      ]
                    }
                  }
                }
              },
              {
                "type": "registryReactive",
                "registryKey": "signScreenLoaded",
                "child": {
                  "type": "visibility",
                  "visible": "{{signScreenLoaded}}",
                  "child": {
                    "crossAxisAlignment": "stretch",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "padding": {
                            "left": 16.0,
                            "top": 16.0,
                            "right": 16.0,
                            "bottom": 16.0
                          },
                          "child": {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "width": 999999.0,
                                  "height": 500.0,
                                  "child": {
                                    "child": {
                                      "mainAxisAlignment": "center",
                                      "children": [
                                        {
                                          "src": "assets/icons/sign-pdf.svg",
                                          "imageType": "asset",
                                          "width": 145.0,
                                          "height": 145.0,
                                          "type": "image"
                                        },
                                        {
                                          "height": 16.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "{{appStrings.promissory.signInstructionsDetail}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 14.0
                                          },
                                          "textAlign": "center",
                                          "textDirection": "rtl",
                                          "type": "text"
                                        }
                                      ],
                                      "type": "column"
                                    },
                                    "type": "center"
                                  },
                                  "type": "container"
                                }
                              ],
                              "type": "column"
                            },
                            "type": "center"
                          },
                          "type": "singleChildScrollView"
                        },
                        "type": "expanded"
                      },
                      {
                        "padding": {
                          "left": 16.0,
                          "top": 16.0,
                          "right": 16.0,
                          "bottom": 16.0
                        },
                        "child": {
                          "type": "reactiveElevatedButton",
                          "loadingKey": "isSigning",
                          "enabled": true,
                          "onPressed": {
                            "actionType": "showDialog",
                            "widget": {
                              "type": "alertDialog",
                              "title": {
                                "type": "column",
                                "mainAxisAlignment": "center",
                                "children": [
                                  {
                                    "type": "container",
                                    "width": 48,
                                    "height": 48,
                                    "child": {
                                      "type": "image",
                                      "src": "assets/icons/ic_info.svg",
                                      "imageType": "asset",
                                      "width": 12,
                                      "height": 12,
                                      "color": "__STAC_OPEN__appColors.current.primary.color}}"
                                    }
                                  },
                                  {
                                    "type": "sizedBox",
                                    "height": 12
                                  },
                                  {
                                    "type": "text",
                                    "data": "__STAC_OPEN__appStrings.promissory.signTitledialog}}",
                                    "textDirection": "rtl",
                                    "textAlign": "center",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 16,
                                      "fontWeight": "bold",
                                      "color": "__STAC_OPEN__appColors.current.text.title}}"
                                    }
                                  }
                                ]
                              },
                              "actions": [
                                {
                                  "type": "container",
                                  "decoration": {
                                    "border": {
                                      "color": "#000000",
                                      "width": 0.8
                                    },
                                    "borderRadius": {
                                      "topLeft": 12.0,
                                      "topRight": 12.0,
                                      "bottomLeft": 12.0,
                                      "bottomRight": 12.0
                                    }
                                  },
                                  "child": {
                                    "type": "elevatedButton",
                                    "onPressed": {
                                      "actionType": "closeDialog"
                                    },
                                    "style": {
                                      "foregroundColor": "__STAC_OPEN__appColors.current.text.title}}",
                                      "elevation": 0.0,
                                      "fixedSize": {
                                        "width": 104.0,
                                        "height": 44.0
                                      },
                                      "shape": {
                                        "type": "roundedRectangleBorder",
                                        "borderRadius": {
                                          "topLeft": 12.0,
                                          "topRight": 12.0,
                                          "bottomLeft": 12.0,
                                          "bottomRight": 12.0
                                        }
                                      }
                                    },
                                    "child": {
                                      "type": "text",
                                      "data": "__STAC_OPEN__appStrings.common.cancel}}",
                                      "textDirection": "rtl",
                                      "style": {
                                        "type": "custom",
                                        "fontSize": 16,
                                        "fontWeight": "bold",
                                        "color": "__STAC_OPEN__appColors.current.text.title}}"
                                      }
                                    }
                                  }
                                },
                                {
                                  "type": "elevatedButton",
                                  "onPressed": {
                                    "actionType": "sequence",
                                    "actions": [
                                      {
                                        "actionType": "closeDialog"
                                      },
                                      {
                                        "actionType": "promissorySign",
                                        "unsignedContract": "__STAC_OPEN__form.unsigned_pdf}}",
                                        "signLocation": {
                                          "x": 450,
                                          "y": 450,
                                          "width": 150,
                                          "height": 50,
                                          "x_ios": 450,
                                          "y_ios": 450,
                                          "width_ios": 150,
                                          "height_ios": 50,
                                          "page": 0
                                        },
                                        "promissoryTitle": "__STAC_OPEN__appStrings.promissory.promissory}}",
                                        "onSuccess": {
                                          "actionType": "sequence",
                                          "actions": [
                                            {
                                              "actionType": "setValue",
                                              "key": "isSigning",
                                              "value": true
                                            },
                                            {
                                              "actionType": "networkRequest",
                                              "url": "http://192.168.107.22:8280/api/digitalbanking/files/v1.0/promissory/upload/base64",
                                              "method": "post",
                                              "headers": {
                                                "accept": "*/*",
                                                "app-platform": "android",
                                                "app-store": "application/json",
                                                "app-version": "456",
                                                "device-uuid": "5109ab4c-77ca-4f0c-9858-da4df58031d2",
                                                "serviceauthorization": "Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==",
                                                "authorization": "__STAC_OPEN__auth.accessToken}}"
                                              },
                                              "data": {
                                                "fileName": "promisorry.pdf",
                                                "contentType": "application/pdf",
                                                "base64": "__STAC_OPEN__form.signed_pdf}}"
                                              },
                                              "results": [
                                                {
                                                  "statusCode": 200,
                                                  "action": {
                                                    "actionType": "sequence",
                                                    "actions": [
                                                      {
                                                        "actionType": "networkRequest",
                                                        "url": "http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/finalize/__STAC_OPEN__form.promissory_id}}",
                                                        "method": "post",
                                                        "headers": {
                                                          "accept": "*/*",
                                                          "app-platform": "android",
                                                          "app-store": "application/json",
                                                          "app-version": "456",
                                                          "device-uuid": "5109ab4c-77ca-4f0c-9858-da4df58031d2",
                                                          "serviceauthorization": "Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==",
                                                          "authorization": "__STAC_OPEN__auth.accessToken}}"
                                                        },
                                                        "data": {
                                                          "signedPdfId": "__STAC_OPEN__data_payload.id}}"
                                                        },
                                                        "results": [
                                                          {
                                                            "statusCode": 200,
                                                            "action": {
                                                              "actionType": "sequence",
                                                              "actions": [
                                                                {
                                                                  "actionType": "setValue",
                                                                  "key": "isSigning",
                                                                  "value": false
                                                                },
                                                                {
                                                                  "actionType": "setValue",
                                                                  "values": [
                                                                    {
                                                                      "key": "promissoryId",
                                                                      "value": "__STAC_OPEN__data.data.promissoryId}}"
                                                                    },
                                                                    {
                                                                      "key": "transactionAmount",
                                                                      "value": "__STAC_OPEN__form.promissory_amount}}"
                                                                    },
                                                                    {
                                                                      "key": "serverSignedPdfId",
                                                                      "value": "__STAC_OPEN__data.data.serverSignedPdfId}}"
                                                                    },
                                                                    {
                                                                      "key": "requestId",
                                                                      "value": "__STAC_OPEN__data.data.requestId}}"
                                                                    },
                                                                    {
                                                                      "key": "trackingNumber",
                                                                      "value": "__STAC_OPEN__data.data.trackingNumber}}"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "request": {
                                                                    "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.promissory_real_success/1",
                                                                    "body": {
                                                                      "operator": "is",
                                                                      "dimension": {
                                                                        "app": "mobile"
                                                                      }
                                                                    },
                                                                    "method": "post",
                                                                    "headers": {
                                                                      "Accept": "*/*",
                                                                      "Content-Type": "application/json"
                                                                    }
                                                                  },
                                                                  "actionType": "navigate",
                                                                  "navigationStyle": "pushReplacement"
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          {
                                                            "statusCode": -1,
                                                            "action": {
                                                              "actionType": "sequence",
                                                              "actions": [
                                                                {
                                                                  "actionType": "setValue",
                                                                  "key": "isSigning",
                                                                  "value": false
                                                                },
                                                                {
                                                                  "actionType": "showSnackBar",
                                                                  "content": {
                                                                    "type": "text",
                                                                    "data": "__STAC_OPEN__appStrings.promissory.signError}}"
                                                                  }
                                                                }
                                                              ]
                                                            }
                                                          }
                                                        ]
                                                      }
                                                    ]
                                                  }
                                                },
                                                {
                                                  "statusCode": -1,
                                                  "action": {
                                                    "actionType": "sequence",
                                                    "actions": [
                                                      {
                                                        "actionType": "setValue",
                                                        "key": "isSigning",
                                                        "value": false
                                                      },
                                                      {
                                                        "actionType": "showSnackBar",
                                                        "content": {
                                                          "type": "text",
                                                          "data": "__STAC_OPEN__appStrings.promissory.signError}}"
                                                        }
                                                      }
                                                    ]
                                                  }
                                                }
                                              ]
                                            }
                                          ]
                                        },
                                        "onFailure": {
                                          "actionType": "showSnackBar",
                                          "content": {
                                            "type": "text",
                                            "data": "__STAC_OPEN__appStrings.promissory.signError}}"
                                          }
                                        }
                                      }
                                    ]
                                  },
                                  "style": {
                                    "foregroundColor": "__STAC_OPEN__appColors.current.primary.onPrimary}}",
                                    "backgroundColor": "__STAC_OPEN__appColors.current.primary.color}}",
                                    "elevation": 0.0,
                                    "fixedSize": {
                                      "width": 104.0,
                                      "height": 44.0
                                    },
                                    "shape": {
                                      "type": "roundedRectangleBorder",
                                      "borderRadius": {
                                        "topLeft": 12.0,
                                        "topRight": 12.0,
                                        "bottomLeft": 12.0,
                                        "bottomRight": 12.0
                                      }
                                    }
                                  },
                                  "child": {
                                    "type": "text",
                                    "data": "__STAC_OPEN__appStrings.common.confirm}}",
                                    "textDirection": "rtl",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 16,
                                      "fontWeight": "bold",
                                      "color": "__STAC_OPEN__appColors.current.primary.onPrimary}}"
                                    }
                                  }
                                }
                              ],
                              "insetPadding": {
                                "left": 16.0,
                                "top": 24.0,
                                "right": 16.0,
                                "bottom": 24.0
                              }
                            }
                          },
                          "style": {
                            "backgroundColor": "{{appColors.current.primary.color}}",
                            "elevation": 0.0,
                            "fixedSize": {
                              "width": 999999.0,
                              "height": 56.0
                            },
                            "shape": {
                              "type": "roundedRectangleBorder",
                              "borderRadius": {
                                "topLeft": 12.0,
                                "topRight": 12.0,
                                "bottomLeft": 12.0,
                                "bottomRight": 12.0
                              }
                            }
                          },
                          "child": {
                            "data": "{{appStrings.promissory.signTitle}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.primary.onPrimary}}",
                              "fontSize": 18.0,
                              "fontWeight": "bold"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        },
                        "type": "padding"
                      }
                    ],
                    "type": "column"
                  }
                }
              }
            ]
          },
          "type": "expanded"
        }
      ],
      "type": "column"
    },
    "type": "scaffold"
  }
}
```
