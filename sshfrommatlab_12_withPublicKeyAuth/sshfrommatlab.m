function channel  =  sshfrommatlab(userName,hostName,password,pemFile)
%SSHFROMMATLAB connects Matlab to a remote computer via a secure shell
%
% CONN  =  SSHFROMMATLAB(USERNAME,HOSTNAME,PASSWORD,PEMFILE)
%
% Inputs:
%   USERNAME is the user name required for the remote machine
%   HOSTNAME is the name of the remote machine
%   PASSWORD is the password for the account USERNAME@HOSTNAME
%   (If no PEM file exists or if PEM file is encrypted then you must specify the password.
%   Otherwise, this argument will be ignored and can be set to null/''(Null string))
%   PEMFILE is the fully qualified path of the filename containing a DSA or RSA
%   private key of the user in OpenSSH key format
%   (Can't miss the "-----BEGIN DSA PRIVATE KEY-----" or "-----BEGIN RSA
%   PRIVATE KEY-----" tag. This argument should be set to null/''(Null
%   string) if no PEM file exists.)
%
% Outputs:
%   CONN is a Java ch.ethz.ssh2.Connection object
%
% See also SSHFROMMATLABCLOSE, SSHFROMMATLABINSTALL, SSHFROMMATLABISSUE
%
% (c) 2008 British Oceanographic Data Centre
%    Adam Leadbetter (alead@bodc.ac.uk)
%     2010 Boston University - ECE
%    David Scott Freedman (dfreedma@bu.edu)
%    Version 1.1
%     2011 Arizona State University - CIDSE
%    Mithila Nagendra (mnagendra@asu.edu)
%

%
%  Invocation checks
%
if(nargin  ~=  4)
    error('Error: SSHFROMMATLAB requires 4 input arguments...');
end
if(~ischar(userName)  || ~ischar(hostName)  ||  ~ischar(password) ||  ~ischar(pemFile))
    error...
        (['Error: SSHFROMMATLAB requires all input ',...
        'arguments to be strings...']);
end
%
%  Build the connection using the JSch package
%
try
    import ch.ethz.ssh2.*;
    
    try
        channel  =  Connection(hostName);
        channel.connect();
    catch
        error(['Error: SSHFROMMATLAB could not connect to the'...
            ' remote machine %s ...'],...
            hostName);
    end
catch
    error('Error: SSHFROMMATLAB could not find the SSH2 java package');
end
%
%  Check the authentication for login...
%

try
    import java.io.File;
catch
    error('Error: SSHFROMMATLAB could not find the java.io.File package');
end

if(~isempty(pemFile))
    try
        authkey = java.io.File(pemFile);
    catch
        error(['Error: SSHFROMMATLAB could not open private key file'...
            ' %s ...'],...
            pemFile);
    end
    isAuthenticated = channel.authenticateWithPublicKey(userName,authkey,password);
else
    %%Original Code
    isAuthenticated = channel.authenticateWithPassword(userName,password);
end



if(~isAuthenticated)
    error...
        (['Error: SSHFROMMATLAB could not authenticate the',...
        ' SSH connection...']);
end