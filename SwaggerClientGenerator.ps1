# Utility class used to generate a C# client from a swagger file URL
class SwaggerClientGenerator
{
    [string]$GenerationTargetPath
    [string]$SwaggerFileSourceUrl
    [string]$SwaggerGeneratorPath
    [string]$SwaggerGeneratorConfigFilePath

    SwaggerClientGenerator([string]$generationTargetPath, [string]$swaggerFileSourceUrl, [string]$swaggerGeneratorPath)
    {
        $this.GenerationTargetPath = Join-Path -Path $PSScriptRoot -ChildPath $generationTargetPath
        $this.SwaggerFileSourceUrl = $swaggerFileSourceUrl
        $this.SwaggerGeneratorPath = Join-Path -Path $PSScriptRoot -ChildPath $swaggerGeneratorPath
        $this.SwaggerGeneratorConfigFilePath = Join-Path -Path $PSScriptRoot -ChildPath "config.json"
    }

    [void]
    Generate()
    {
        Write-Host("Generation started for url '$( $this.swaggerFileSourceUrl )'");
        $this.EnsureUrlReachable();
        $this.CleanTargetDirectory();
        $this.ExecutGenerationTool();
    }

    [void]
    ExecutGenerationTool()
    {
        Write-Host("Generating code using swagger codegen CLI");
        java -jar $this.SwaggerGeneratorPath generate -l csharp -i $this.SwaggerFileSourceUrl  -o $this.GenerationTargetPath -c $this.SwaggerGeneratorConfigFilePath
        Write-Host("Generation finished");
    }

    [void]
    CleanTargetDirectory()
    {
        Write-Host("Cleaning target generation folder '$( $this.GenerationTargetPath )'");
        Remove-Item -Path $this.GenerationTargetPath -Recurse -Force -ErrorAction Ignore
        Write-Host("Cleaning finished");
    }

    [void]
    EnsureUrlReachable()
    {
        [int]$expectedStatusCode = 200;
        [int]$actualStatusCode = $this.GetStatusCodeForUrl($this.SwaggerFileSourceUrl);
        if ($actualStatusCode -eq $expectedStatusCode)
        {
            Write-Host("Provided url responded with code '$expectedStatusCode'. Url is considered valid. Proceeding ...");
        }
        else
        {
            throw "Provided url responded with invalid status code '$expectedStatusCode'. Generation cannot proceed. Ensure that the target host is running and that a swagger file is located at the provided URL";
        }
    }

    [string]
    GetStatusCodeForUrl([string]$targetUrl)
    {
        # Create the request.
        $request = [System.Net.WebRequest]::Create($targetUrl);

        # Response from the site.
        $response = $request.GetResponse();

        # Get the HTTP code as an integer.
        $responseStatusCode = [int]$response.StatusCode;

        $response.Close();

        return $responseStatusCode;
    }
}