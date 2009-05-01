= WorkerBee

* http://github.com/WanderingMatt/worker_bee/tree/master

== DESCRIPTION:

Given a recipe, builds up a list of todos and executes blocks of work in order of dependency

== FEATURES/PROBLEMS:

* Checks and completes dependencies based on syntax

== SYNOPSIS:

  require 'worker_bee'

  WorkerBee.recipe do
    work :sammich, :meat, :bread do
      puts "** sammich!"
    end

    work :meat, :clean do
      puts "** meat"
    end

    work :bread, :clean do
      puts "** bread"
    end

    work :clean do
      puts "** cleaning!"
    end
  end

  WorkerBee.run :sammich

== REQUIREMENTS:

* None

== INSTALL:

* None

== LICENSE:

(The MIT License)

Copyright (c) 2009 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
