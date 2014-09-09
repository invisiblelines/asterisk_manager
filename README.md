# Asterisk Manager

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
