# SwaggerClientPowershellGenerator
This is a small powershell wrapper to make generating a C# client from a web-hosted swagger doc easier 

This tool is simple to use, but very restrictive. It is a wrapper aroung the original java swagger-codegen utility meant to hide away some of the boilerplate necessary to run it. But, since I'm lazy, I only added the functionality that I needed to use right away ... Pull requests are always welcome.

## What it does
This utility script requires three parameters: 
- The path to the output folder for the generated swagger client
- The URL to the web-hosted swagger document
- The URL to the swagger-codegene java utility

The first and third parameters can be specified as either absolute or relative file path and must represent the full path, including location and name of the file.

Running this tool will create a complete project, `.csproj` included.

## Usage

``` Powershell
// Include generator class
. "absolute/path/to/SwaggerClientGenerator.ps1"
// Instanciate utility classe
$SwaggerGenerator = [SwaggerGenerator]::new("path/to/output/folder", "https://url-to-swagger.doc", "path/to/swagger/codegen/tool");
// Run generator
$SwaggerGenerator.Generate();
 ```
