abstract class IaProvider {
  Future<String?> getAnalysisByImage(String imagePath);
  Future<String?> getAnalysisByPDF(String pdfPath);

  String get prompt => """
    Prompt here ...
  """;
}
