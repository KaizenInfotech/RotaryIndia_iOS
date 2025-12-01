import Foundation
//-->BASE URL

//Live
//var baseUrl:String! = "http://rotaryindiaapi.rosteronwheels.com/api/"


//Test 2022
//var baseUrl:String! = "http://rotaryindiaapi.rosteronwheels.com/api/"
//var baseUrl:String! = "http://rotaryindiaapi.rosteronwheels.com/api/"

//http://rotaryindiaapi.rosteronwheels.com/api/Gallery/AddUpdateAlbum_New :-
//----------------------------------//row live
//Test
//var baseUrl:String! = "http://rowtestapi.rosteronwheels.com/V4/api/"
//After transfering backend data to new server
//var baseUrl:String! = "http://apitest.rotary-india.org/V4/api/"

//http://rowtestapi.rosteronwheels.com/V4/api/Gallery/GetAlbumDetails_New
//testing
//var baseUrl:String! = "http://rowtestapi.rosteronwheels.com/V4/api/"
//----------------------------------//row testing
var baseUrlTermsnCondition:String! = "http://touchbase.in/mobile/term-n-conditions.html"
var baseUrlSubscribes:String! = "http://touchbase.in/mobile/subscribes.html"

//-->RELATIVE URL----------------- Path For API's --------------
let k_API_Gallery="Gallery/GetAlbumsList"
let k_API_GalleryGetAlbumPhotoList="Gallery/GetAlbumPhotoList"
let touchBase_fetchAttendanceList:String="Attendance/GetAttendanceList"
let touchBase_fetchNewsletterInfo:String="Ebulletin/GetYearWiseEbulletinList"
let touchBase_fetchDistrictCommittee:String="ServiceDirectory/GetServiceCategoriesData"
let touchBase_fetchNotificationCount:String="Group/GetNotificationCount"
let touchBase_GetfeedbackEmailId:String="Group/GetEmail"
let touchBase_UpdateDocumentIsRead:String="DocumentSafe/UpdateDocumentIsRead"
let touchBase_GetServiceDirectoryListSync:String="OfflineData/GetServiceDirectoryListSync"
let touchBase_GetMonthEventList:String="Celebrations/GetMonthEventList"
let touchBase_GetServiceDirectoryCategories:String="ServiceDirectory/GetServiceDirectoryCategories"
let touchbase_DeleteAlbum:String="Group/DeleteByModuleName"
let touchbase_AddAlbumUpdate:String="Gallery/AddUpdateAlbum"
let touchBase_DeleteAlbumPhoto:String = "Gallery/DeleteAlbumPhoto"
let touchBase_GetAlbumDetails:String = "Gallery/GetAlbumDetails"
let touchBase_GetAnnouncementDetails="Announcement/GetAnnouncementDetails"
let touchBase_UploadImag="upload/UploadImage?module=announcement"
let touchBase_AddAnnouncements="Announcement/AddAnnouncement"
let touchBase_GetAllGroupListSync="Group/GetAllGroupListSync"
let touchBase_DeleteByModuleName="Group/DeleteByModuleName"
let row_GetClubPublicGallery="FindClub/GetPublicAlbumsList"
let rowDistrictEventDetailsFromCalendar="Celebrations/GetEventMinDetails"
let rowCelebreationBirthDayAnniversaryEvent="/Celebrations/GetMonthEventListTypeWise"
let rowCelebreationDatewiseData="/Celebrations/GetMonthEventListDetails"

//-----------ONLINE API---------------------------

let directoryOnline="Member/GetMemberListSyncOnline"
let dirClassificationOnline="District/GetClassificationList_new"
let dirClassificationMemberList="District/GetMemberByClassification"
let dirClassificationDetail="District/GetMemberWithDynamicFields"
let dirFamilyOnline="FindRotarian/GetFamilyList"
let dirMemberDetailV1="FindRotarian/GetRotarianDetails_V1"
let dirFamilyDetail="FindRotarian/GetRotarianDetails"
let distdirectoryOnline="District/GetDistrictMemberList"
let distdirectoryDetailOnline="District/GetMemberWithDynamicFields"
let rIImgText="Login/Get_Project_master_details"


//--find rotarian
//need to change deepak code by rajendra jat
let touchBase_FindRotarianGetRotarianList="FindRotarian/GetRotarianList"
let touchBase_GetUpdateProfileDetails="member/UpdateProfileDetails"

let touchBase_GetMemberListSync="Member/GetMemberListSync"
let touchBAse_GetDistrictListSync="District/GetDistrictMemberListSync"

let row_GetClubList="FindClub/GetClubList"
let row_GetClubDetails="FindClub/GetClubDetails"
let row_GetClubNearMe="FindClub/GetClubsNearMe"
let row_GetDistrictClubList="District/GetClubs" 
let row_GetDistrictClubDetails="District/GetClubDetails"//District
let row_GetDistricCommunicationtEventList="FindClub/GetPublicEventsList"
let row_GetDistrictCommunicationNewsLetterList="FindClub/GetPublicNewsletterList"
let row_GetBirthDayAnniversaryNotification="Celebrations/GetTodaysBirthday"

/*---------------------------------------------------------------------------*/
let row_LoginUserLogin:String = "Login/UserLogin"
let row_LoginRegistration:String = "Login/Registration"
let row_GetBodMemberList:String = "Member/GetBODList"
let row_GetPastPresidentList:String = "PastPresidents/getPastPresidentsList"
let row_GetFindRotarianDetails:String = "FindRotarian/GetRotarianDetails"
let row_GetWebLinkList:String = "WebLink/GetWebLinksList"
let row_GetRotaryLibraryDetails:String = "Group/GetRotaryLibraryData"
let row_GetSettingDetails:String = "/Setting/GetGroupSetting"
let row_UpdateSetting:String = "Setting/GroupSetting"
let row_ClubInfoDetails:String = "Group/GetClubDetails"
let row_ClubHistory:String = "Group/GetClubHistory"
let row_SendFeedback:String = "Group/Feedback"
let row_Getsmscountdetails = "Event/Getsmscountdetails"
let touchBase_GetChangedMemberProfile="Member/UploadProfilePhoto"
let touchBase_GetRemovedMemberProfile="Group/DeleteImage"

let rowAppVersionGetAllGroupList="Group/GetAllGroupsList"
let getMobilePupup = "Group/getMobilePupup"
let UpdateMobilePupupflag = "Group/UpdateMobilePupupflag"
let row_GetDistrictCommiteList:String="District/GetDistrictCommittee"   ////District
let row_GetMemberSegmentList:String="FindClub/GetClubMembers"

/*------------------------------------------------------------------------------*/

let row_GetMemberSegmentDetails:String = "FindRotarian/GetrotarianDetails"
let row_GetDashboardBirthAnniEvent:String = "Group/GetNewDashboard"

//Constant for Gallery
let k_API_profileIdD="profileId"
let k_API_groupId="groupId"
let k_API_updatedOn="updatedOn"
let k_API_ModuleIDAlbum="moduleId"
//Constant for gallery get album photo list
let k_API_GalleryPhotoListAlbumId="albumId"
let k_API_GalleryPhotoListGroupId="groupId"
let k_API_GalleryPhotoListUpdatedOn="updatedOn"
//----------------- Constants for Attendance --------------
let k_API_groupProfileID="groupProfileID"
let k_API_month="month"
let k_API_year="year"
let k_API_moduleID="moduleID"
//----------------- Constants for Attendance --------------
let touchBase_groupProfilerId:String="groupProfileID"
let touchBase_month:String="month"
let touchBase_year:String="year"
let touchBase_moduleId:String="moduleID"
//directory zip file
let k_API_DirectoryZipFile="grpID"

//---------------- Constants For API Response handle -----------
let k_API_ResponseSuccess = "success"
let k_API_Data = "data"
let k_API_Error = "error"
let k_API_Message = "message"
//---------------- Constants for API Tasks ----------------
//---------------- Constants for API send mail for Feedback
let k_API_grpIDFeedBack = "grpID"
let k_API_moduleIDFeedBack = "moduleID"
//----------------Constants for API root screen Notification Count
let k_API_masterUID = "masterUID"
//----------------Constants for API root screen Document Detail
let k_API_DocID = "DocID"
let k_API_memberProfileID = "memberProfileID"
//---------------Constant for API Calendar Month
let k_API_profileId = "profileId"
let k_API_groupIds = "groupId"
let k_API_selectedDate = "selectedDate"
let k_API_updatedOns = "updatedOn"
let k_API_name = "name"
let k_API_classification = "classification"
let k_API_club = "club"
let k_API_districtnumber = "district_number"


/*
 
 profileId
 groupId
 selectedDate
 updatedOn
 */



enum TaskType : Int {
    case kTaskResgister
    case kTaskLogin
    case kTaskCountryList
    case kTaskVarification
    case kTaskGetStoreList
    case kTaskGetCouponList
    case kTaskVerifyStorePin
    case kTaskGetHelpITServices
    case kTaskGetHelpITSPList
    case kTaskGetHelpITFillForm
    case kTaskGetWebsiteURL
    case kTaskGetDynamicImageURL
    case kTaskGetOutletList
    case kTaskGetProductList
    case kTaskGetFAQ
    case kTaskGetAbout
    case kTaskTermsAndCondition
    case kTaskGetPlayList
    case kTaskGetPaymentHistoryList
    case kTaskGetAddressFromGoogle
    case kTaskGetServiceCharges
    case kTaskBookACab
    case kTaskGetAcInfo
    case kTaskClosePopUpAd
    case kTaskNotificationList
    case kTaskRefreshLatLong
    case kTaskResetPW
    case kTaskUpdatePW
    case kTaskSendCartOnServer
    case kTaskPaymentRequest
    case kTaskPaymentRequestWallet
    case kTaskGetWalletAmount
    case kTaskUpdateWalletAmount
    case kTaskGetContactList
    case kUserProfileDetailList
}

//-------------------------- Constants for HTTP Request method type ------------------
enum HTTPMethod : Int {
    case get
    case post
    case put
    case delete
    case patch
}
