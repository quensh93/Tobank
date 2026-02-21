# NetworkRequest `dataBind` Guide (Conflict-Free Response Access)

## Summary
This guide documents the new `dataBind` feature for `networkRequest`.

Problem solved:
- multiple API calls in one screen used shared global keys (`data`, `data_payload`)
- later calls could overwrite earlier response values
- nested request chains were hard to reason about

With `dataBind`, each request can store response data in its own namespace:
- `responses.<bind>.raw`
- `responses.<bind>.payload`
- `responses.<bind>.data` (alias of `payload`, preferred naming)
- `responses.<bind>.statusCode`
- `responses.<bind>.headers`
- `responses.<bind>.ok`
- `responses.<bind>.timestamp`

---

## Supported Input

`networkRequest` now accepts:
- `dataBind` (canonical)
- `data_bind` (alias for compatibility)

Example:

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/users",
  "method": "get",
  "dataBind": "fetchUsers",
  "results": []
}
```

---

## What Gets Stored

For `dataBind: "fetchUsers"`:

- `responses.fetchUsers.raw`
  - full response body
- `responses.fetchUsers.payload`
- `responses.fetchUsers.data`
  - extraction order:
    1. `response.data.data`
    2. `response.data.result.data`
    3. fallback to full response body
- `responses.fetchUsers.statusCode`
- `responses.fetchUsers.headers`
- `responses.fetchUsers.ok`
  - `true` for 2xx, else `false`
- `responses.fetchUsers.timestamp`
  - epoch milliseconds

Backward compatibility (still written exactly as before):
- `data` (latest response body)
- `data_payload` (latest extracted payload)

---

## Why `responses.` Namespace Exists

Using a namespace prevents conflicts with existing keys:
- `form.*`
- `auth.*`
- `userData.*`
- custom app-level keys

Without namespace, flat keys like `res1` can collide with unrelated registry values.

---

## Template Usage Patterns

Success data:
- `{{responses.fetchUsers.payload}}`
- `{{responses.fetchUsers.payload.id}}`
- `{{responses.fetchUsers.data}}`
- `{{responses.fetchUsers.data.id}}`

Raw body fields:
- `{{responses.fetchUsers.raw.status.message.0}}`

Status-driven logic:
- `{{responses.fetchUsers.statusCode}}`
- `{{responses.fetchUsers.ok}}`

Headers:
- `{{responses.fetchUsers.headers.x-trace-id.0}}`

---

## Full Example 1: Multi-Request In One Screen

Goal:
- request 1: profile
- request 2: accounts
- request 3: offers
- no collisions

```json
{
  "actionType": "sequence",
  "actions": [
    {
      "actionType": "networkRequest",
      "url": "https://api.example.com/profile",
      "method": "get",
      "dataBind": "profileRes",
      "results": [
        {
          "statusCode": 200,
          "action": {
            "actionType": "setValue",
            "values": [
              { "key": "screen.profileName", "value": "{{responses.profileRes.payload.name}}" },
              { "key": "screen.profileNationalId", "value": "{{responses.profileRes.payload.nationalId}}" }
            ]
          }
        },
        {
          "statusCode": -1,
          "action": {
            "actionType": "showSnackBar",
            "content": {
              "type": "text",
              "data": "{{responses.profileRes.raw.status.message.0 ?? 'Profile request failed'}}"
            }
          }
        }
      ]
    },
    {
      "actionType": "networkRequest",
      "url": "https://api.example.com/accounts",
      "method": "get",
      "dataBind": "accountsRes",
      "results": [
        {
          "statusCode": 200,
          "action": {
            "actionType": "setValue",
            "values": [
              { "key": "screen.accounts", "value": "{{responses.accountsRes.payload}}" },
              { "key": "screen.firstAccountId", "value": "{{responses.accountsRes.payload.0.id}}" }
            ]
          }
        }
      ]
    },
    {
      "actionType": "networkRequest",
      "url": "https://api.example.com/offers?accountId={{screen.firstAccountId}}",
      "method": "get",
      "dataBind": "offersRes",
      "results": [
        {
          "statusCode": 200,
          "action": {
            "actionType": "setValue",
            "values": [
              { "key": "screen.offers", "value": "{{responses.offersRes.payload}}" },
              { "key": "screen.hasOffers", "value": true }
            ]
          }
        },
        {
          "statusCode": -1,
          "action": {
            "actionType": "setValue",
            "values": [
              { "key": "screen.hasOffers", "value": false },
              { "key": "screen.offerErrorCode", "value": "{{responses.offersRes.statusCode}}" }
            ]
          }
        }
      ]
    }
  ]
}
```

Result:
- each response is isolated:
  - `responses.profileRes.*`
  - `responses.accountsRes.*`
  - `responses.offersRes.*`
- no accidental overwrite by later requests

---

## Full Example 2: Nested Request Chain (Complicated)

Scenario:
1. Upload signed PDF
2. If upload success, call finalize API using uploaded file id
3. If finalize success, fetch receipt details
4. Keep all three responses independently accessible for screen render/debug

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/files/uploadBase64",
  "method": "post",
  "dataBind": "uploadSignedPdf",
  "data": {
    "fileName": "signed.pdf",
    "contentType": "application/pdf",
    "base64": "{{form.signed_pdf}}"
  },
  "results": [
    {
      "statusCode": 200,
      "action": {
        "actionType": "networkRequest",
        "url": "https://api.example.com/promissory/finalize/{{form.promissory_id}}",
        "method": "post",
        "dataBind": "finalizePromissory",
        "data": {
          "signedPdfId": "{{responses.uploadSignedPdf.payload.id}}"
        },
        "results": [
          {
            "statusCode": 200,
            "action": {
              "actionType": "networkRequest",
              "url": "https://api.example.com/promissory/receipt/{{responses.finalizePromissory.payload.requestId}}",
              "method": "get",
              "dataBind": "receiptRes",
              "results": [
                {
                  "statusCode": 200,
                  "action": {
                    "actionType": "setValue",
                    "values": [
                      { "key": "receipt.trackingNumber", "value": "{{responses.finalizePromissory.payload.trackingNumber}}" },
                      { "key": "receipt.serverSignedPdfId", "value": "{{responses.finalizePromissory.payload.serverSignedPdfId}}" },
                      { "key": "receipt.downloadUrl", "value": "{{responses.receiptRes.payload.downloadUrl}}" }
                    ]
                  }
                },
                {
                  "statusCode": -1,
                  "action": {
                    "actionType": "showSnackBar",
                    "content": {
                      "type": "text",
                      "data": "{{responses.receiptRes.raw.status.message.0 ?? 'Receipt fetch failed'}}"
                    }
                  }
                }
              ]
            }
          },
          {
            "statusCode": -1,
            "action": {
              "actionType": "showSnackBar",
              "content": {
                "type": "text",
                "data": "{{responses.finalizePromissory.raw.status.message.0 ?? 'Finalize failed'}}"
              }
            }
          }
        ]
      }
    },
    {
      "statusCode": -1,
      "action": {
        "actionType": "showSnackBar",
        "content": {
          "type": "text",
          "data": "{{responses.uploadSignedPdf.raw.status.message.0 ?? 'Upload failed'}}"
        }
      }
    }
  ]
}
```

Why this is stable:
- inner request does not overwrite outer bind data
- each stage can read its own success/error context
- you can still inspect latest `data` and `data_payload` if needed

---

## Dart Builder Example

```dart
StacNetworkRequestAction(
  url: 'https://api.example.com/accounts',
  method: 'get',
  dataBind: 'accountsRes',
  results: [
    {
      'statusCode': 200,
      'action': {
        'actionType': 'setValue',
        'key': 'screen.accounts',
        'value': '{{responses.accountsRes.payload}}',
      },
    },
  ],
);
```

---

## Migration Notes

### Recommended
- new screens: always set unique `dataBind` for every request
- nested requests: always refer to parent response through `responses.<bind>.*`

### Incremental Migration (Existing Screens)
1. Add `dataBind` to each request.
2. Replace ambiguous references first:
   - `{{data_payload.id}}` style references in nested/multi-request flows.
3. Leave remaining legacy references temporarily.
4. Migrate fully to `responses.<bind>.*` when convenient.

---

## Naming Conventions

Use meaningful bind names:
- `fetchUnsignedPdf`
- `uploadSignedPdf`
- `finalizePromissory`
- `fetchDeposits`

Avoid generic names in production:
- `res1`, `res2` are acceptable for quick tests only.

---

## Troubleshooting

If value is empty:
1. Verify request has `dataBind`.
2. Verify template path uses the same bind name.
3. Check whether field is in `payload` or only in `raw`.
4. Check status code path:
   - some non-200 responses may have only `raw.status.message`.

Quick debug keys:
- `{{responses.myBind.statusCode}}`
- `{{responses.myBind.ok}}`
- `{{responses.myBind.raw}}`
- `{{responses.myBind.payload}}`
- `{{responses.myBind.data}}`

---

## Compatibility Guarantee

Current behavior is non-breaking:
- legacy keys (`data`, `data_payload`) are still populated
- `dataBind` adds a safer structured path
- both styles can coexist during migration
