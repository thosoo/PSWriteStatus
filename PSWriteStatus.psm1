<#
BSD 2-Clause License

Copyright (c) 2021, Thaison Nguyen
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #>

function Write-Status {
   param (
      [Parameter(Mandatory=$true,
         ValueFromPipeline=$true)]
      [string]$Text,
      [bool]$Done,
      [bool]$Nok,
      [bool]$Loading
   )
   process{
      if ($Done) {
         if ($Nok) {
            Write-Host "`r[-] $Text"
         }else {
            Write-Host "`r[+] $Text"
         }
      } elseif ($Loading) {
         [int]$time = (New-TimeSpan -Start (Get-Date "01/01/1970") -End (Get-Date)).TotalSeconds
         $timemod = ($time % 8)
		 switch ($timemod){
		 	0 {Write-Host "`r[|] $Text"  -NoNewline}
		 	1 {Write-Host "`r[/] $Text"  -NoNewline}
		 	2 {Write-Host "`r[-] $Text"  -NoNewline}
		 	3 {Write-Host "`r[\] $Text"  -NoNewline}
		 	4 {Write-Host "`r[|] $Text"  -NoNewline}
		 	5 {Write-Host "`r[/] $Text"  -NoNewline}
		 	6 {Write-Host "`r[-] $Text"  -NoNewline}
		 	7 {Write-Host "`r[\] $Text"  -NoNewline}
		 }
      }
      else {
         Write-Host "[*] $Text" -NoNewline
      }
   }
}

Export-ModuleMember -Function Write-Status
