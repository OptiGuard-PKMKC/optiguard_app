String getConditionName(String name) {
  switch (name.toLowerCase()) {
    case 'glaucoma':
      return 'Glaukoma';
    case 'diabetic_retinopathy':
      return 'Diabetik Retinopati';
    case 'normal':
      return 'Normal';
    case 'cataract':
      return 'Katarak';
    default:
      return name; // Return original name if no match found
  }
}