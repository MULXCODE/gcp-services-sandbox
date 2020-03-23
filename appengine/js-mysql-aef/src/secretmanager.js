/* 
 ** Reference: https://cloud.google.com/secret-manager/docs/creating-and-accessing-secrets#add_a_secret_version 
 */

// Import the Secret Manager client and instantiate it:
const {
    SecretManagerServiceClient
} = require('@google-cloud/secret-manager');
const client = new SecretManagerServiceClient();

// gcloud services enable secretmanager.googleapis.com --project elevated-watch-270607
/**
 * TODO(developer): Uncomment these variables before running the sample.
 */
// parent = 'projects/my-project', // Project for which to manage secrets.
// secretId = 'foo', // Secret ID.
// payload = 'hello world!' // String source data.

let parent = 'projects/elevated-watch-270607'
let secretId = 'foo'
let payload = 'hello'

async function updateSecret() {
    // const name = 'projects/my-project/secrets/my-secret';
    const [secret] = await client.updateSecret({
        secret: {
            name: `${parent}/secrets/${secretId}`,
            labels: {
                secretmanager: 'rocks',
            },
        },
        updateMask: {
            paths: ['labels'],
        },
    });

    console.info(`Updated secret ${secret.name}`);
}


async function createAndAccessSecret() {
    // Create the secret with automation replication.
    const [secret] = await client.createSecret({
        parent: parent,
        secret: {
            name: secretId,
            replication: {
                automatic: {},
            },
        },
        secretId,
    });

    console.info(`Created secret ${secret.name}`);

    // Add a version with a payload onto the secret.
    const [version] = await client.addSecretVersion({
        parent: secret.name,
        payload: {
            data: Buffer.from(payload, 'utf8'),
        },
    });

    console.info(`Added secret version ${version.name}`);

    // Access the secret.
    const [accessResponse] = await client.accessSecretVersion({
        name: version.name,
    });

    const responsePayload = accessResponse.payload.data.toString('utf8');
    console.info(`Payload: ${responsePayload}`);
}

async function addSecretVersion() {
    const [version] = await client.addSecretVersion({
        parent: `${parent}/secrets/${secretId}`,
        payload: {
            data: Buffer.from(payload, 'utf8'),
        },
    });
    console.log(version);
}


async function listSecrets() {
    const [secrets] = await client.listSecrets({
        parent: parent,
    });

    secrets.forEach(secret => {
        const policy = secret.replication.replication;
        console.log(`${secret.name} (${policy})`);
    });
}


async function listSecretVersions() {
    const [versions] = await client.listSecretVersions({
        parent: parent + '/secrets/' + secretId,
    });

    versions.forEach(version => {
        console.log(`${version.name}: ${version.state}`);
    });
}


async function getSecret() {
    console.log(`${parent}/secrets/${secretId}`)
    const [secret] = await client.getSecret({
        name: `${parent}/secrets/${secretId}`
    });

    const policy = secret.replication.replication;

    console.log(secret);
    console.info(`Found secret ${secret.name} (${policy})`);
}

/**
 * TODO(developer): Uncomment these variables before running the sample.
 */
// const name = 'projects/my-project/secrets/my-secret/versions/5';
// const name = 'projects/my-project/secrets/my-secret/versions/latest';

async function accessSecretVersion() {
    const [version] = await client.accessSecretVersion({
        name: `${parent}/secrets/${secretId}/versions/latest`,
    });

    // Extract the payload as a string.
    const payload = version.payload.data.toString('utf8');

    // WARNING: Do not print the secret in a production environment - this
    // snippet is showing how to access the secret material.
    console.info(`Secret Value: ${payload}`);
}


// createAndAccessSecret();

// console.log('listSecrets')
// listSecrets();

// console.log('getSecret')
// getSecret()

// accessSecretVersion();

// updateSecret();

// addSecretVersion()
// listSecretVersions();

module.exports = {
    updateSecret,
    createAndAccessSecret,
    addSecretVersion,
    listSecrets,
    listSecretVersions,
    getSecret,
    accessSecretVersion
}