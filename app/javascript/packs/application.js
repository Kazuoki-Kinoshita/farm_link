// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import '@popperjs/core';
import "jquery"
require("@nathanvda/cocoon") 

import { profileTemplate } from './templates/profile_template';

function removeBanchi(address) {
  const regex = /([0-9０-９]+|[一二三四五六七八九十百千万]+)*(([0-9０-９]+|[一二三四五六七八九十百千万]+)|(丁目|丁|番地|番|号|-|‐|ー|−|の|東|西|南|北){1,2})*(([0-9０-９]+|[一二三四五六七八九十百千万]}+)|(丁目|丁|番地|番|号){1,2})/;
  return address.replace(regex, '');
}

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  const templateButton = document.getElementById('template-button');
  const hiddenProfile = document.getElementById('hidden-profile');
  const profileOutput = document.getElementById('profile-output');
  const nameInput = document.querySelector("input[placeholder='農園・農家名を入力してください']");
  const addressInput = document.querySelector("input[placeholder='農園・農地の住所を入力してください']");
  const productInput = document.querySelector("input[placeholder='農作物を入力してください']");

  if (templateButton && profileOutput) {
    templateButton.addEventListener('click', () => {
      const name = nameInput.value;
      const address = removeBanchi(addressInput.value);
      const product = productInput.value;
      const templateText = profileTemplate(name, address, product);
      profileOutput.innerHTML = templateText;
      hiddenProfile.value = profileOutput.textContent;
    });
  }

  if (profileOutput) {
    profileOutput.addEventListener('input', () => {
      hiddenProfile.value = profileOutput.textContent;
    });
  }

  if (profileOutput) {
    // 編集画面で保存されたプロフィールデータを表示する
    const savedProfile = hiddenProfile.value;
    if (savedProfile) {
      profileOutput.innerHTML = savedProfile.replace(/\n/g, '<br>');
    }
  
    // profileOutputの変更をhiddenProfileに反映する
    profileOutput.addEventListener('input', () => {
      hiddenProfile.value = profileOutput.textContent;
    });
  }
});