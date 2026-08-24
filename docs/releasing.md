# Releasing almost

Every pull request and push to `main` builds Windows, Linux, macOS, and Web artifacts.
Pushing a tag beginning with `v` also creates a GitHub Release.

## macOS secrets

Add these repository secrets under **Settings -> Secrets and variables -> Actions** before
creating the first version tag:

| Secret | Value |
| --- | --- |
| `APPLE_CERTIFICATE_BASE64` | Base64-encoded Developer ID Application `.p12` certificate. |
| `APPLE_CERTIFICATE_PASSWORD` | Password used when exporting the `.p12` certificate. |
| `APPLE_ID` | Apple ID email address used for notarization. |
| `APPLE_TEAM_ID` | Apple Developer Team ID. |
| `APPLE_APP_SPECIFIC_PASSWORD` | App-specific password generated for the Apple ID. |

On macOS, create the certificate secret with:

```sh
base64 -i DeveloperIDApplication.p12 | pbcopy
```

Paste the copied value into `APPLE_CERTIFICATE_BASE64`. Do not commit the certificate
or any of these values to the repository.

## Create a release

```sh
git tag v0.1.0
git push origin v0.1.0
```

The workflow builds the game, signs and notarizes the macOS app, then attaches all
platform archives to the GitHub Release.
