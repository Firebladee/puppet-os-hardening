# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: os_hardening::minimize_access
#
# Configures profile.conf.
#
class os_hardening::minimize_access (
  $allow_change_user   = false,
  $always_ignore_users =
    ['root','sync','shutdown','halt'],
  $ignore_users        = [],
){
  # from which folders to remove public access
  $folders = [
    '/usr/local/sbin',
    '/usr/local/bin',
    '/usr/sbin',
    '/usr/bin',
#    '/sbin', # os differance
#    '/bin',  # os differance
  ]

  # remove write permissions from path folders ($PATH) for all regular users
  # this prevents changing any system-wide command from normal users
  file { $folders:
    ensure  => 'directory',
#    links   => 'follow', # os differance
    mode    => 'go-w',
    recurse => true,
  }
  # shadow must only be accessible to user root
  file { '/etc/shadow':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # su must only be accessible to user and group root
  if $allow_change_user {
    file { '/bin/su':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0750',
    }
  }

  # retrieve system users through custom fact
  $system_users = split($::retrieve_system_users, ',')

  # build array of usernames we need to verify/change
  $ignore_users_arr = union($always_ignore_users, $ignore_users)

  # build a target array with usernames to verify/change
  $target_system_users = difference($system_users, $ignore_users_arr)

  # ensure accounts are locked (no password) and use nologin shell
  # os differance
#  user { $target_system_users:
#    ensure   => present,
#    shell    => '/sbin/nologin',
#    password => '*',
#  }
}
