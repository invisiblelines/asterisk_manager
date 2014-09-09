# Asterisk Manager

[![Build Status](https://travis-ci.org/kieranj/asterisk_manager.svg?branch=master)](https://travis-ci.org/kieranj/asterisk_manager)
[![Code Climate](https://codeclimate.com/github/kieranj/asterisk_manager/badges/gpa.svg)](https://codeclimate.com/github/kieranj/asterisk_manager)
[![Coverage Status](https://coveralls.io/repos/kieranj/asterisk_manager/badge.png)](https://coveralls.io/r/kieranj/asterisk_manager)
[![Dependency Status](https://gemnasium.com/kieranj/asterisk_manager.svg)](https://gemnasium.com/kieranj/asterisk_manager)
[![Gem Version](https://badge.fury.io/rb/asterisk_manager.svg)](http://badge.fury.io/rb/asterisk_manager)

## Overview

A block based DSL for interacting with the Asterisk Manager through a TCP connection.

## Installation

    $ gem install asterisk_manager

## Usage

    require 'asterisk_manager'

    AsteriskManager::Client.start('host', 'user', 'secret') do |asterisk|
      asterisk.dial('SIP/123testphone', '7275551212')
    end

## Copyright

Copyright (c) 2009 Kieran Johnson. See LICENSE for details.
