function calculate (){
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const addProfit = document.getElementById('profit');
  if (!priceInput){ return false;}
  priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value);
      const taxPrice = Math.floor(price * 0.1);
      addTaxPrice.textContent = taxPrice;
      addProfit.textContent = price - taxPrice;
  });
};

window.addEventListener('turbo:load', calculate);