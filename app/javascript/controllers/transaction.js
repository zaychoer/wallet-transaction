export default class TransactionCtrl {
  toogleSelectedItem() {
    const el = currentElement();
    const currentSelectedItem = el.selectedOptions[0].text;
    if (currentSelectedItem == 'transfer') {
      return toggleClass('#receiver', 'hidden');
    }
    addClass('#receiver', 'hidden');
  }
}
