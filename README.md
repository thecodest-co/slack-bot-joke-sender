# Joke sender

This is a serverless app that can be linked to [SlackBot](https://github.com/thecodest-co/slack-bot).

The app sends a joke downloaded from external API every Monday, Wednesday and Friday to Slack channel. It also sends the joke in the thread if anyone mentions @Cody.

### How to run locally
instal serverless framework: `npm install -g serverless`

install gems: `bundle install`

install packages: `npm install`

run app: `sls offline`