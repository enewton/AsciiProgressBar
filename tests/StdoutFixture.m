classdef StdoutFixture < matlab.unittest.fixtures.Fixture
    properties (Access = private)
        filename
        fid
    end

    methods
        function setup(fixture)
            fixture.filename = tempname;
            fixture.fid = fopen(fixture.filename, 'w');
        end

        function fid = stream(fixture)
            fid = fixture.fid;
        end

        function output = currentOutput(fixture)
            fclose(fixture.fid);
            output = fileread(fixture.filename);
            fixture.fid = fopen(fixture.filename, 'a');
        end

        function teardown(fixture)
            fclose(fixture.fid);
            delete(fixture.filename);
            disp(['Deleted: ', fixture.filename])
        end
    end
end
