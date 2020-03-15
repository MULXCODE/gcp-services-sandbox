const GoogleStrategy = require('passport-google-oauth2')
    .Strategy;

AUTH_CONFIG = {
    clientID: process.env.CLIENT_ID,
    clientSecret: process.env.CLIENT_SECRET,
    callbackURL: "http://localhost:8082/auth/google/callback",
    passReqToCallback: true
};

module.exports = function (passport) {
    passport.serializeUser((user, done) => {
        done(null, user);
    });

    passport.deserializeUser((user, done) => {
        done(null, user);
    });

    passport.use(new GoogleStrategy(AUTH_CONFIG, 
        (request, token, refreshToken, profile, done) => {
            return done(null, {
                profile: profile,
                token: token
            });
        })
    );
};