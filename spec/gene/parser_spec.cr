require "../spec_helper"

describe Gene::Parser do
  {
    '1'        => 1,
    # ''         => Gene::Types::Stream.new,
    # '#END'     => Gene::Types::Stream.new,
    # '"a double-quoted String"' => "a double-quoted String",
    # "'a single-quoted String'" => "a single-quoted String",
    # "\"a \nmulti-line \nString\"" => "a \nmulti-line \nString",
    # '"a"'      => "a",
    # "1 #END\n2"=> 1,
    # '-1'       => -1,
    # '1.0'      => 1.0,
    # '-1.0'     => -1.0,
    # 'true'     => true,
    # 'truea'    => Gene::Types::Symbol.new('truea'),
    # 'false'    => false,
    # 'null'     => nil,
    # 'undefined'=> Gene::UNDEFINED,
    # 'void'     => Gene::UNDEFINED,
    # '#_'       => Gene::PLACEHOLDER,
    # # '#a'       => Gene::Types::Ref.new('a'),
    # '\#'       => Gene::Types::Symbol.new('#', true),
    # '\#a'      => Gene::Types::Symbol.new('#a', true),
    # 'a'        => Gene::Types::Symbol.new('a'),
    # '#//'      => //,
    # '#//mxi'   => //mxi,
    # "#/\\n/"   => /\n/,
    # # Quoted symbol, support escaping with "\"
    # # '#""'      => Gene::Types::Symbol.new(''),
    # # "#''"      => Gene::Types::Symbol.new(''),
    # 'a b'      => Gene::Types::Stream.new(Gene::Types::Symbol.new('a'), Gene::Types::Symbol.new('b')),
    # '(#STREAM a)' => Gene::Types::Stream.new(Gene::Types::Symbol.new('a')),
    # '\\('      => Gene::Types::Symbol.new('(', true),
    # '()'       => Gene::NOOP,
    # '1 ()'     => Gene::Types::Stream.new(1, Gene::NOOP),
    # '("a")'    => Gene::Types::Base.new("a"),
    # '(a)'      => Gene::Types::Base.new(Gene::Types::Symbol.new('a')),
    # '(a b)'    => Gene::Types::Base.new(Gene::Types::Symbol.new('a'), Gene::Types::Symbol.new('b')),
    # '(a, b,)'  => Gene::Types::Base.new(Gene::Types::Symbol.new('a'), Gene::Types::Symbol.new('b')),
    # '((a).b)'  => Gene::Types::Base.new(Gene::Types::Base.new(Gene::Types::Symbol.new('a')), Gene::Types::Symbol.new('.b')),
    # '(#.. 1 2)'  => 1..2,
    # '(#<> 1 2)'  => Set.new([1, 2]),

    # # Below two should be handled by the parser
    # # # line comment
    # # #< comment out up to >#
    # # TODO need to add more tests espectially for structural comments
    # "#!/usr/bin/env glang\n 1"    => 1,  # Special case: treat unix shebang as comment
    # "(a # b\n)"                   => Gene::Types::Base.new(Gene::Types::Symbol.new('a')),
    # "a #< this is a test >#"      => Gene::Types::Symbol.new('a'),
    # "#< this is a test ># a"      => Gene::Types::Symbol.new('a'),
    # "[a #< this is a test >#]"    => [Gene::Types::Symbol.new('a')],
    # "{^a 1 #< this is a test >#}" => {'a' => 1},
    # "(a #< this is a test ># b)"  => Gene::Types::Base.new(Gene::Types::Symbol.new('a'), Gene::Types::Symbol.new('b')),

    # '(a (b))'  => Gene::Types::Base.new(Gene::Types::Symbol.new('a'), Gene::Types::Base.new(Gene::Types::Symbol.new('b'))),
    # '[a]'      => [Gene::Types::Symbol.new('a')],
    # '[^a]'     => [Gene::Types::Symbol.new('^a')],
    # '[^^a]'    => [Gene::Types::Symbol.new('^^a')],
    # #'(\[\] a)' => Gene::Types::Base.new(Gene::Types::Symbol.new('[]'), Gene::Types::Symbol.new('a')),
    # '[[a]]'    => [[Gene::Types::Symbol.new('a')]],
  }.each do |input, result|
    it "parse #{input} should work" do
      Gene::Parser.parse(input).should == result
    end
  end
end
