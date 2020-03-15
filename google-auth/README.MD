# AUTHENTICATION SCOPES

* [DEVELOPERS GOOGLE APIS SCOPES](https://developers.google.com/identity/protocols/oauth2/scopes#peoplev1)

## Getting Started

1. Download OAuth 2.0 Credential from Google APIs Console and update `source.env` with the corresponding CLIENT_ID and CLIENT_SECRET.  Also when configuring the credential, allow redirect URI for: `http://localhost:8082/auth/google/callback`.

```bash
cat > source.env << EOF
export CLIENT_ID="*****.apps.googleusercontent.com"
export CLIENT_SECRET="*****************"
EOF
```

2. Run `npm install`
3. Run `source source.env`
4. Run `node server.js`
