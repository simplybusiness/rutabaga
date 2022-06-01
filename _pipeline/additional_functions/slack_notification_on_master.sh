#!/bin/bash

function slack_pre_notification_on_master_gem_version {
  local gem_version=$(gem_version "rutabaga.gemspec")
  if [[ "${ENVIRONMENT}" == "live" ]] && [[ "${BRANCH_NAME}" == 'master' ]]; then
    slack_notification "$APP_NAME" "$APP_SLACK_DEPLOYMENT_CHANNEL" "$NOTICE_COLOR_PRE_NOTIFY" "${SLACK_MESSAGE_PRE_NOTIFY} v${gem_version}"
  fi
}
function slack_post_notification_on_master_gem_version {
  local gem_version=$(gem_version "rutabaga.gemspec")
  if [[ "${ENVIRONMENT}" == "live" ]] && [[ "${BRANCH_NAME}" == 'master' ]]; then
    slack_notification "$APP_NAME" "$APP_SLACK_DEPLOYMENT_CHANNEL" "$NOTICE_COLOR_POST_NOTIFY" "${SLACK_MESSAGE_POST_NOTIFY} v${gem_version}"
  fi
}

function send_notifications {
  if [[ "${BRANCH_NAME}" == 'master' ]]; then
    bnw_slack_notify_final_workflow_status
  fi
}
