const PORT = 8082;

const express = require('express'),
    app = express(),
    passport = require('passport'),
    auth = require('./auth'),
    cookieParser = require('cookie-parser'),
    cookieSession = require('cookie-session'),
    path = require('path'),
    mustacheExpress = require('mustache-express');

auth(passport);
app.use(passport.initialize());

app.use(cookieSession({
    name: 'session',
    keys: ['SECRECT KEY'],
    maxAge: 24 * 60 * 60 * 1000
}));
app.use(cookieParser());

app.engine('html', mustacheExpress());
app.set('view engine', 'html');
app.set('views', __dirname, '/src/views');
app.use("/styles", express.static(__dirname + '/styles'));

app.get('/', (req, res) => {
    // console.log(req);

    if (req.session.token) {
        res.cookie('token', req.session.token);
        res.render('src/views/logged-in.html', {token: req.session.token });
        
//         res.send(`Session Cookie: ${req.session.token} 
// <a href="/logout" class="btn btn-primary">Logout</a>`);
    } else {
        res.cookie('token', '')
        res.render('src/views/logged-out.html', {token: req.session.token });

        // res.render(path.join(__dirname + '/index.html'), {token: 'null' });
    }
});


app.get('/token', (req, res) => {
    res.json(req.session.token);
});

app.get('/logout', (req, res) => {
    req.logout();
    req.session = null;
    res.redirect('/');
});

app.get('/auth/google', passport.authenticate('google', {
    scope: 
    [ 'https://www.googleapis.com/auth/plus.login', 
    'https://www.googleapis.com/auth/plus.profile.emails.read' ]}
));

app.get('/auth/google/callback',
    passport.authenticate('google', {
        failureRedirect: '/'
    }),
    (req, res) => {
        console.log(req.user.token);

        req.session.token = req.user.token;

        res.redirect('/');
    }
);

app.listen(PORT, () => {
    console.log('Server is running on port ' + PORT);
});
