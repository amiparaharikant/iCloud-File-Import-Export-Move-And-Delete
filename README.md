# iCloud-File-Import-Export-Move-And-Delete

Step 1: Add into your info.Plist

<key>NSUbiquitousContainers</key>
<dict>
	<key>iCloud.com.iCloudFileImportExport</key> //com.iCloudFileImportExport -> is yuor Bundle Id Replace with yours
	<dict>
		<key>NSUbiquitousContainerIsDocumentScopePublic</key>
		<true/>
		<key>NSUbiquitousContainerSupportedFolderLevels</key>
		<string>Any</string>
		<key>NSUbiquitousContainerName</key>
		<string>$(PRODUCT_NAME)</string>
	</dict>
</dict>
  
  
  Step 2: Setup With iCloud from project
  	project -> Capability -> iCloud
	- Enable(ON) iCloud and enable services 1. key-value-storage & 2. iCloude Documents
	

NOTE : if you can't syn data with iCloud just increment version and build value from general setting.
	
