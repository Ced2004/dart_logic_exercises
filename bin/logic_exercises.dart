
String evaluateStudentPerformance(String studentName, List<dynamic> rawGrades) {
  double totalScore = 0.0;
  int validSubjectCount = 0;

  print('Processing grades for: $studentName...');

  for (var grade in rawGrades) {
    try {
      double parsedGrade = double.parse(grade.toString());

      if (parsedGrade < 0 || parsedGrade > 100) {
        throw FormatException('Grade $parsedGrade is out of range (0-100).');
      }

      totalScore += parsedGrade;
      validSubjectCount++;
      print('  -> Valid grade recorded: $parsedGrade');
    } catch (e) {
      print('  [ERROR CAUGHT]: Could not process grade "$grade". Reason: $e');
    }
  }

  if (validSubjectCount == 0) {
    return 'Status: INCOMPLETE - No valid grades recorded for $studentName.';
  }

  double averageGrade = totalScore / validSubjectCount;
  print('Calculated Average: ${averageGrade.toStringAsFixed(2)}');

  if (averageGrade >= 75.0) {
    return 'Status: PASSED (Congratulations $studentName!)';
  } else {
    return 'Status: FAILED (Needs Retake)';
  }
}

void main() {
  print('=== NTC GRADE EVALUATION SYSTEM ===\n');

  List<double> goodGrades = [85.5, 90.0, 78.25, 88.0];
  print('--- TEST 1: Valid Student Data ---');
  String result1 = evaluateStudentPerformance('Juan Dela Cruz', goodGrades);
  print('$result1\n');

  List<dynamic> mixedGradesWithErrors = [82.0, -15.0, "INVALID_GRADE", 76.5];
  print('--- TEST 2: Testing Bad Input with Try/Catch ---');
  String result2 = evaluateStudentPerformance('Maria Clara', mixedGradesWithErrors);
  print('$result2\n');

  print('====================================');
}
