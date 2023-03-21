class JobModal {
  String? employerName;
  String? employerLogo;
  String? employerWebsite;
  String? jobPublisher;
  String? jobId;
  String? jobEmploymentType;
  String? jobTitle;
  String? jobApplyLink;
  String? jobDescription;
  bool? jobIsRemote;
  int? jobPostedAtTimestamp;
  String? jobPostedAtDatetimeUtc;
  String? jobCity;
  String? jobState;
  String? jobCountry;
  double? jobLatitude;
  double? jobLongitude;

  String? jobGoogleLink;

  JobRequiredExperience? jobRequiredExperience;

  JobRequiredEducation? jobRequiredEducation;
  bool? jobExperienceInPlaceOfEducation;

  JobHighlights? jobHighlights;

  JobModal(
      {this.employerName,
      this.employerLogo,
      this.employerWebsite,
      this.jobPublisher,
      this.jobId,
      this.jobEmploymentType,
      this.jobTitle,
      this.jobApplyLink,
      this.jobDescription,
      this.jobIsRemote,
      this.jobPostedAtTimestamp,
      this.jobPostedAtDatetimeUtc,
      this.jobCity,
      this.jobState,
      this.jobCountry,
      this.jobLatitude,
      this.jobLongitude,
      this.jobGoogleLink,
      this.jobRequiredExperience,
      this.jobRequiredEducation,
      this.jobExperienceInPlaceOfEducation,
      this.jobHighlights});

  JobModal.fromJson(Map<String, dynamic> json) {
    employerName = json['employer_name'];
    employerLogo = json['employer_logo'];
    employerWebsite = json['employer_website'];
    jobPublisher = json['job_publisher'];
    jobId = json['job_id'];
    jobEmploymentType = json['job_employment_type'];
    jobTitle = json['job_title'];
    jobApplyLink = json['job_apply_link'];
    jobDescription = json['job_description'];
    jobIsRemote = json['job_is_remote'];
    jobPostedAtTimestamp = json['job_posted_at_timestamp'];
    jobPostedAtDatetimeUtc = json['job_posted_at_datetime_utc'];
    jobCity = json['job_city'];
    jobState = json['job_state'];
    jobCountry = json['job_country'];
    jobLatitude = json['job_latitude'];
    jobLongitude = json['job_longitude'];

    jobGoogleLink = json['job_google_link'];

    jobRequiredExperience = json['job_required_experience'] != null
        ? JobRequiredExperience.fromJson(json['job_required_experience'])
        : null;

    jobRequiredEducation = json['job_required_education'] != null
        ? JobRequiredEducation.fromJson(json['job_required_education'])
        : null;
    jobExperienceInPlaceOfEducation =
        json['job_experience_in_place_of_education'];

    jobHighlights = json['job_highlights'] != null
        ? JobHighlights.fromJson(json['job_highlights'])
        : null;
  }

  static List<JobModal> ListJobs(List data) {
    List<JobModal> res = [];
    res = data.map((datas) {
      return JobModal.fromJson(datas);
    }).toList();

    return res;
  }
}

class JobRequiredExperience {
  bool? noExperienceRequired;
  int? requiredExperienceInMonths;
  bool? experienceMentioned;
  bool? experiencePreferred;

  JobRequiredExperience(
      {this.noExperienceRequired,
      this.requiredExperienceInMonths,
      this.experienceMentioned,
      this.experiencePreferred});

  JobRequiredExperience.fromJson(Map<String, dynamic> json) {
    noExperienceRequired = json['no_experience_required'];
    requiredExperienceInMonths = json['required_experience_in_months'];
    experienceMentioned = json['experience_mentioned'];
    experiencePreferred = json['experience_preferred'];
  }
}

class JobRequiredEducation {
  bool? postgraduateDegree;
  bool? professionalCertification;
  bool? highSchool;
  bool? associatesDegree;
  bool? bachelorsDegree;
  bool? degreeMentioned;
  bool? degreePreferred;
  bool? professionalCertificationMentioned;

  JobRequiredEducation(
      {this.postgraduateDegree,
      this.professionalCertification,
      this.highSchool,
      this.associatesDegree,
      this.bachelorsDegree,
      this.degreeMentioned,
      this.degreePreferred,
      this.professionalCertificationMentioned});

  JobRequiredEducation.fromJson(Map<String, dynamic> json) {
    postgraduateDegree = json['postgraduate_degree'];
    professionalCertification = json['professional_certification'];
    highSchool = json['high_school'];
    associatesDegree = json['associates_degree'];
    bachelorsDegree = json['bachelors_degree'];
    degreeMentioned = json['degree_mentioned'];
    degreePreferred = json['degree_preferred'];
    professionalCertificationMentioned =
        json['professional_certification_mentioned'];
  }
}

class JobHighlights {
  List<String>? qualifications;
  List<String>? responsibilities;
  List<String>? benefits;

  JobHighlights({this.qualifications, this.responsibilities, this.benefits});

  JobHighlights.fromJson(Map<String, dynamic> json) {
    List<String>? list = json['Qualifications'] != null
        ? List<String>.from(json['Qualifications'].map((value) {
            return value.toString();
          }))
        : null;
    List<String>? list1 = json['Responsibilities'] != null
        ? List<String>.from(json['Responsibilities'].map((value) {
            return value.toString();
          }))
        : null;
    List<String>? list3 = json['Benefits'] != null
        ? List<String>.from(json['Benefits'].map((value) {
            return value.toString();
          }))
        : null;

    qualifications = list;

    responsibilities = list1;
    benefits = list3;
  }
}
