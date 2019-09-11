. "absolute/path/to/SwaggerClientGenerator.ps1"

$SwaggerGenerator = [SwaggerClientGenerator]::new("./ElasticsearchClient", "http://localhost:56312/swagger/docs/v1", "swagger-codegen-cli.jar");

$SwaggerGenerator.Generate();

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
