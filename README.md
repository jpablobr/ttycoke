# TTYCoke [![Build Status](https://secure.travis-ci.org/jpablobr/ttycoke.png?branch=master)][travis]

[travis]: http://travis-ci.org/jpablobr/ttycoke

TTYCoke lets one modify the colorset of a running program (that
display output to the command-line) based on predefined regular
expression. Basically it's wrapper around the program, executing it
and parsing its stdout stream (where it will apply the matching
rules/colors).

## <a name="Before-After"></a>Before/After

[![before](http://i.imgur.com/XNpy4.png)][before] [![after](http://i.imgur.com/JEFJ2.png)][after]

[before]: http://i.imgur.com/XNpy4.png
[after]: http://i.imgur.com/JEFJ2.png


[![before](http://i.imgur.com/8gzEX.png)][before] [![after](http://i.imgur.com/SF7Cp.png)][after]

[before]: http://i.imgur.com/8gzEX.png
[after]: http://i.imgur.com/SF7Cp.png

Initial disclaimer! This mess is raw, like sushi. So, haters to the left.

anyway, 

## <a name="Installation"></a>Installation :)

For specific Ruby version requirements, see the [Travis build](http://travis-ci.org/#!/jpablobr/ttycoke). ATM > 1.9.

With RubyGems, simply open a terminal and type:

    $ {sudo} gem install ttycoke

Local installation:

[Download](http://github.com/jpablobr/ttycoke/download) the tarball package and:

    $ tar -xvzf ttycoke-{version}.tgz

or

    $ git clone https://github.com/jpablobr/ttycoke.git

then 

    $ cd ttycoke-{version}
    $ {sudo} rake install

Now you are ready to start coking! 

## <a name="Usage"></a>Usage

    $ ttycoke {program-name}

If the program exist in the config file, it will use its rules to `ttycoke`
it, otherwise it will fallback to its normal execution.

You can also define your own rules for things such as `tailing` your logs! Something like the following should work:

Create an executable shell script and name it lets say, `my_awesome_app_logs.sh` with:

    #!/bin/sh
    tail -f ~/apps/my_awesome_app/log/**/*.log

Then in your terminal you can `ttycoke` it as such:

    $ ttycoke my_awesome_app_logs.sh # <3<3<3

if you were creative enough, you'll be seeing rainbows! 

Again, it's just a wrapper around the program, It just parses it
stdout stream, so its capable of much more!

## <a name="Configuration"></a>Configuration
The following rake task will copy the `ttycoke/config/config.yaml` file to your `$HOME` directory as `.ttycokerc`. 

    $ rake setup 

This file contains the regular expression rules and it's also where you'll be adding yours!

## <a name="How-it-works"></a>How it works

Basically it's just 1:1 match to the specified colors in the regular
expression groups. So for example, with the following rule:

    lsmod:
      regex: !ruby/regexp 
        /^(?<green>\w+)(?<uncolored>\s+)(?<blue>\d+)(?<uncolored>\s+)(?<yellow>\d+)(?<magenta>.+)/

the lsmod program will be matched as follows: (I know kind of obvious)

    '/^(?<green>\w+)(?<uncolored>\s+)(?<blue>\d+)(?<uncolored>\s+)(?<yellow>\d+)(?<magenta>.+)/'
        |            |                |           |                |             |
        |            |                |           |                |             \_: magenta
        |            |                |           |                \_: yellow
        |            |                |           \_: uncolored
        |            |                \_:blue
        |            \_:uncolored
        \_:green

Based on that you can now take it a bit further and for example the
following will create a green/red TDD kind of output:

     ((?<green>success)|(?<red>fail|error))

The first screenshot is based of the following:

    tail_tork_logs:
      -
        results:
          regex: !ruby/regexp 
            /^(?<underscore>Finished.*)/
        error:
          regex: !ruby/regexp 
            /(?<red>.+(Error|Failure):)/
        expected:
          regex: !ruby/regexp 
            /(?<blue>--- expected)/
        expected-string:
          regex: !ruby/regexp 
            /(?<blue>-\".+)/
        actual:
          regex: !ruby/regexp 
            /(?<red>\++ actual)/
        actual-string:
          regex: !ruby/regexp 
            /(?<red>\+\".+)/
        at:
          regex: !ruby/regexp 
            /(?<on_yellow>@.+)/
        stats:
          regex: !ruby/regexp 
            /(?<white>\d+ tests, )(?<green>\d+ assertions, )(?<magenta>\d+ failures, )(?<red>\d+ errors, )(?<yellow>\d+ skips)/


and the `tail_tork_logs` looks like this:

    #!/bin/sh

    tail -f log/test/**/*.log

That's just from `tailing` the ouput of the [Tork](https://github.com/sunaku/tork) continuous testing framework.

## <a name="todo"></a>TODO
* Add more sample regular expression parsers.

## <a name="copyright"></a>Copyright
Copyright (c) 2012 Jose Pablo Barrantes. See [LICENSE][] for details.

[license]: https://github.com/jpablobr/ttycoke/blob/master/LICENSE
