class ApiEndpoints {
  static const String baseurl = "http://93.127.195.102/backend/api/v1/";
  static const String login = '${baseurl}login';
  static const String getZone = '${baseurl}zones';
  static const String agentRegister = '${baseurl}register-repo-agent';
  static const String agentRegisterByOfficeStaf =
      '${baseurl}create-repo-agent-by-staff';

  static const String getStateByzone = '${baseurl}get-state-by-zone';
  static const String getCityByState = '${baseurl}get-city-by-state';
  static const String getHomeDashboard = '${baseurl}office-staff-dashboard';
  static const String getHomeDashboardRepoStaff = '${baseurl}agent-dashboard';
  static const String getAllVehicleData = '${baseurl}get-all-data';

  static const String searchvehicle = '${baseurl}search-details';
  static const String getAllRepo = '${baseurl}get-all-repo-agents';
  static const String updateRepoStatus =
      '${baseurl}change-agent-status-by-staff';
  static const String updateRepoPassword =
      '${baseurl}change-agent-password-staff';
  static const String holdreport = '${baseurl}hold-vehicle-list';
  static const String repoDataReport = '${baseurl}repo-vehicle-list';
  static const String releaseDataReport = '${baseurl}release-vehicle-list';
  static const String updatePassByOff = '${baseurl}update-password';
  static const String updatePassByRepoAgent =
      '${baseurl}update-password-by-agent';
  static const String searchDataReport =
      '${baseurl}search-vehicle-list-by-staff';
  static const String viewRequest = '${baseurl}request-for-staff';
  static const String updateHoldVehicleStatus =
      '${baseurl}change-vehicle-status-by-staff';
  static const String holdvehicleByrepoagent = '${baseurl}hold-request';
  static const String updateSearchRepoList = '${baseurl}search-vehicle';
  static const String updatedeviceid = '${baseurl}change-agent-device-by-staff';
  static const String holdGraphData = '${baseurl}hold-graph';
  static const String searchGraphData = '${baseurl}search-graph';
  static const String releaseGraphData = '${baseurl}release-graph';
  static const String repoGraphData = '${baseurl}repo-graph';
  static const String getAllRepoAgents = '${baseurl}get-all-repo-agents';
  static const String changeVehicleStatusByStaff =
      '${baseurl}change-vehicle-status-by-staff/';
}
