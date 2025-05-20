Cloudflare Page Rules Export & Import Scripts
Overview

These two PowerShell scripts allow you to export and import Page Rules for a specific Cloudflare zone using the Cloudflare API. This can be useful for:

    Backing up existing page rules.

    Migrating rules between zones.

    Bulk editing or replication across environments.

Scripts Included
1. Export-PageRules.ps1

Exports all Page Rules from a specified Cloudflare zone and saves them to a local JSON file.
2. Import-PageRules.ps1

Reads a previously exported JSON file and imports the Page Rules into the specified Cloudflare zone.
Technologies Used

    PowerShell: For scripting and automation.

    Cloudflare API v4: To interact with Page Rules.

    JSON over HTTPS: Standard REST API communication.

Prerequisites

Before using the scripts, ensure you have:

    PowerShell 5.1+ (Windows) or PowerShell Core (macOS/Linux).

    A valid Cloudflare account.

    Your Cloudflare:

        Email address

        Global API Key

        Zone ID

Configuration

In both scripts, update the following variables with your information:

$authEmail = "your-email@example.com"
$authKey   = "your-global-api-key"
$zoneId    = "your-zone-id"

Usage
Exporting Page Rules

    Open Export-PageRules.ps1.

    Set your credentials and zone ID.

    Run the script in PowerShell.

    The rules will be saved as pagerules_export.json.

.\Export-PageRules.ps1

Importing Page Rules

    Open Import-PageRules.ps1.

    Confirm the inputFile variable points to the JSON file exported previously.

    Set your credentials and zone ID.

    Run the script in PowerShell.

.\Import-PageRules.ps1

    Note: The script removes the "id" field from the rules during import to avoid update conflicts.

Output

    Export: Creates pagerules_export.json in the current directory.

    Import: Prints status messages for each rule (success/failure).

Safety Tips

    Always verify rules before importing them to a live environment.

    Back up existing rules prior to importing changes.

    Test on a staging zone when possible.

License

These scripts are provided under the MIT License. You are free to use, modify, and distribute them.
