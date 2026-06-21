/// Known flow names under `lib/stac/tobank/flows/`, used to derive the flow
/// segment of a logical `fileName`.
///
/// A simple `split('_').first` is wrong because several flows are multi-word
/// (`deposit_more`, `child_loan`, ...). Longest-prefix matching against this
/// set recovers the correct flow.
class FlowRegistry {
  FlowRegistry._();

  static const Set<String> flows = {
    'biometric_test',
    'card_management',
    'cartable',
    'charge',
    'child_loan',
    'dashboard',
    'deposit_more_options',
    'deposit_turnover',
    'gift_card',
    'home_page',
    'installment_payment',
    'login',
    'marriage_loan',
    'notification',
    'internet_pakage',
    'profile',
    'promissory',
    'promissory_guarantee',
    'transaction',
    'transfer',
    'user_credit_validation',
    'authentication',
  };

  static const Map<String, String> flowAliases = {'tobank': 'home_page'};

  /// Returns the flow that owns [fileName] by longest-prefix match.
  ///
  /// The `'${f}_'` boundary check ensures `deposit` never shadows
  /// `deposit_more`, and prevents partial-word matches. Returns `null` when no
  /// flow matches.
  static String? flowOf(String fileName) {
    String? best;
    for (final flow in flows) {
      final isMatch = fileName == flow || fileName.startsWith('${flow}_');
      if (isMatch && (best == null || flow.length > best.length)) {
        best = flow;
      }
    }
    for (final entry in flowAliases.entries) {
      final alias = entry.key;
      final flow = entry.value;
      final isMatch = fileName == alias || fileName.startsWith('${alias}_');
      if (isMatch && (best == null || alias.length > best.length)) {
        best = flow;
      }
    }
    return best;
  }
}
