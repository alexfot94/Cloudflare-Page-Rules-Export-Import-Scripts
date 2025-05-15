Cloudflare Page Rules Export and Import (PowerShell)
====================================================

Description:
-------------
These PowerShell scripts allow you to export and import Cloudflare Page Rules using the Cloudflare API v4.

Files:
------
1. Export-PageRules.ps1 - Exports all Page Rules for a given domain (zone) to a JSON file.
2. Import-PageRules.ps1 - Imports Page Rules from a previously exported JSON file.

Requirements:
-------------
- PowerShell 5.1 or newer (Windows) or PowerShell Core (Linux/macOS)
- Internet access
- A Cloudflare API Token with the following permissions:
  - Zone:Read (for export)
  - Zone:Edit (for import)

How to Use:
-----------
1. Open both Export-PageRules.ps1 and Import-PageRules.ps1.
2. Replace the placeholders:
   - $apiToken = "your_api_token_here"
   - $zoneName = "example.com"
3. To export page rules:
   - Run Export-PageRules.ps1
   - This will save the rules into pagerules_export.json
4. To import page rules:
   - Run Import-PageRules.ps1
   - This will read pagerules_export.json and recreate the rules on Cloudflare

Notes:
------
- The export creates a file: pagerules_export.json
- The import uses that file to recreate rules
- A 1-second delay is added between imports to avoid API rate limits
- The import script does not delete or check for duplicates

Limitations:
------------
- Page Rules must be recreated exactly. If there are duplicates, they will be created again.
- Error messages from Cloudflare are printed directly to the console.

License:
--------
Free to use and modify. No warranty or guarantees.

Author:
-------
Generated with assistance from ChatGPT
