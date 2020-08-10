FROM mcr.microsoft.com/powershell:7.0.1-ubuntu-18.04 as base
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module PSScriptAnalyzer -RequiredVersion 1.19.0 -Scope AllUsers -Repository PSGallery

FROM base as analyzer
LABEL "com.github.actions.name"         = "PSScriptAnalyzer"
LABEL "com.github.actions.description"  = "Run PSScriptAnalyzer tests"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="green"

LABEL "name"       = "github-action-psscriptanalyzer"
LABEL "version"    = "2.2.1"
LABEL "repository" = "https://github.com/srjennings/github-action-psscriptanalyzer"
LABEL "homepage"   = "https://github.com/PowerShell/PSScriptAnalyzer"
LABEL "maintainer" = "Steve Jennings <steven@automatingops.com>"

ADD entrypoint.ps1  /entrypoint.ps1

COPY LICENSE README.md /

RUN chmod +x /entrypoint.ps1

ENTRYPOINT ["pwsh", "/entrypoint.ps1"]
