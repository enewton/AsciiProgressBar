import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport

addpath(pwd)

suite = testsuite(fullfile(pwd,"tests"));

runner = testrunner();%"textoutput");
reportFormat = CoverageReport("coverageReport");
p = CodeCoveragePlugin.forFolder(pwd,"Producing",reportFormat);
runner.addPlugin(p)

runner.run(suite)

open(fullfile("coverageReport","index.html"))
