require "../spec_helper.cr"

private def parse(string)
  env = Crinja::Environment.new
  lexer = Crinja::Parser::ExpressionLexer.new(env.config, string)
  parser = Crinja::Parser::ExpressionParser.new(lexer)
  parser.parse
end

describe Crinja::Parser::ExpressionParser do
  it "" do
    expression = parse %( "foo")
    expression.should be_a(Crinja::Parser::StringLiteral)
  end

  it "" do
    expression = parse %(1 + 2)
    expression.should be_a(Crinja::Parser::BinaryExpression)
    Crinja::Environment.new.evaluate(expression).should eq 3
  end

  it "parses member operator" do
    expression = parse %(foo.bar)
    expression.should be_a(Crinja::Parser::MemberExpression)
  end

  it "parses double array" do
    evaluate_expression(%([[1,2,3]])).should eq "[[1, 2, 3]]"
  end
end