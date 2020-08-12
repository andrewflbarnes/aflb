// Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

// Modified: 04-08-2020 Andrew Barnes

const aws = require('aws-sdk');
const ses = new aws.SES({region: process.env.region});

const EMAIL_TO = process.env.email_to;
const EMAIL_FROM = process.env.email_from;

exports.handler = (event, context, callback) => {
    const { name, message, contact } = JSON.parse(event.body);

    const params = {
        Destination: {
            ToAddresses: [EMAIL_TO]
        },
        Message: {
            Body: {
                Text: {
                    Data: `From:\n${name}\n\nMessage:\n${message}\n\nContact Details:\n${contact}`
                }
            },
            Subject: {
                Data: `Contact request from ${name}`
            }
        },
        Source: EMAIL_FROM
    };

     ses.sendEmail(params, function (err, data) {
        if (err) {
            callback(err);
        } else {
            callback(null, {
                "statusCode": 202,
                "headers": {
                    "Access-Control-Allow-Origin": "*",
                    "x-invocation-id": context.awsRequestId
                }
            })
        }
    });
};