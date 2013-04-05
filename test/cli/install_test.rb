require 'test_helper'

describe Cask::CLI::Install do
  it "allows install of multiple casks at once" do
    shutup do
      Cask::CLI::Install.run('local-transmission', 'local-caffeine')
    end

    Cask.load('local-transmission').must_be :installed?
    Cask.load('local-caffeine').must_be :installed?
  end

  it "properly handles casks that are not present" do
    out, err = capture_subprocess_io do 
      Cask::CLI::Install.run('what-the-balls')
    end

    (out+err).must_equal <<-OUTPUT.gsub(/^ */, '')
      Error: No available cask for what-the-balls
    OUTPUT
  end
end
