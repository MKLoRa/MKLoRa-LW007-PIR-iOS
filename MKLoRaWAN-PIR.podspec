#
# Be sure to run `pod lib lint MKLoRaWAN-PIR.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-PIR'
  s.version          = '1.0.4'
  s.summary          = 'A short description of MKLoRaWAN-PIR.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MKLoRa/MKLoRa-LW007-PIR-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MKLoRa/MKLoRa-LW007-PIR-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-PIR' => ['MKLoRaWAN-PIR/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-PIR/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-PIR/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-PIR/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-PIR/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-PIR/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-PIR/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'Cell' do |sss|
      sss.subspec 'TextButtonCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Expand/Cell/TextButtonCell/**'
        
        ssss.dependency 'MKBaseModuleLibrary'
        ssss.dependency 'MKCustomUIModule'
      end
    end
    
    ss.subspec 'DatabaseManager' do |sss|
      sss.source_files = 'MKLoRaWAN-PIR/Classes/Expand/DatabaseManager/**'
      
      sss.dependency 'FMDB'
      sss.dependency 'MKBaseModuleLibrary'
    end
    
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'BleSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/BleSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/BleSettingPage/Model'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/BleSettingPage/View'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/BleSettingPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/BleSettingPage/View/**'
      end
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DebuggerPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DebuggerPage/View'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DebuggerPage/View/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DeviceInfoPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DebuggerPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/SelftestPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DeviceSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DeviceSettingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DeviceInfoPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/DeviceSettingPage/Model/**'
      end
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/GeneralPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/HallSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/PIRSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/THSettingsPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/GeneralPage/Model/**'
      end
    end
    
    ss.subspec 'HallSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/HallSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/HallSettingsPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/HallSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaApplicationPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaApplicationPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaApplicationPage/Model/**'
      end
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaApplicationPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaSettingPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaPage/Model/**'
      end
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaSettingPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaSettingPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/LoRaSettingPage/Model/**'
      end
    end
    
    ss.subspec 'PIRSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/PIRSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/PIRSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/PIRSettingsPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/PIRSettingsPage/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/PIRSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/ScanPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/TabBarPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/ScanPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/ScanPage/Model/**'
      end
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/SelftestPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/SelftestPage/Model'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/SelftestPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/SelftestPage/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-PIR/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/BleSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/DeviceSettingPage/Controller'
      end
    end
    
    ss.subspec 'THSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/THSettingsPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/THSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-PIR/Functions/THSettingsPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/THSettingsPage/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/THSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/UpdatePage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-PIR/Functions/UpdatePage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-PIR/Classes/Functions/UpdatePage/Model/**'
      end
    
      sss.dependency 'iOSDFULibrary',     '4.13.0'
    end
    
    ss.dependency 'MKLoRaWAN-PIR/SDK'
    ss.dependency 'MKLoRaWAN-PIR/CTMediator'
    ss.dependency 'MKLoRaWAN-PIR/ConnectModule'
    ss.dependency 'MKLoRaWAN-PIR/Expand'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    
  end
   
end
