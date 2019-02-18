# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


platform :ios, '10.0'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'OHHTTPStubs/Swift'
end


def shared_pods
  pod 'OHHTTPStubs/Swift'
  pod 'NVActivityIndicatorView'
  pod 'OHHTTPStubs/Swift'
end


target 'PaginationAssignment' do
  use_frameworks!
  inhibit_all_warnings!
  
  shared_pods

end

target 'PaginationAssignmentTests' do
  inherit! :search_paths
  inhibit_all_warnings!
  
  shared_pods
  testing_pods
    
end


