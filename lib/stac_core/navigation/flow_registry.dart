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
    'notification',
    'internet_pakage',
    'profile',
    'promissory',
    'transaction',
    'transfer',
    'user_credit_validation',
    'authentication',
  };

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
    return best;
  }
}
