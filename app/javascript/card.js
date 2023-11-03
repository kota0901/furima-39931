const pay = () => {
  console.log("card.jsが読み込まれました");
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // Move this to the top

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.error("Error creating token:", response.error); // Log the error for debugging
        alert("クレジットカード情報の取得に失敗しました。"); // Notify the user
      } else {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit(); // Use the form variable directly
      }

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
  });
};

window.addEventListener("turbo:load", pay);