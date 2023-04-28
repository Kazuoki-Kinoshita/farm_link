function applyYellowMarker(text) {
  if (text.trim() === '') {
    return '<span style="background-color: #FF8C94; display: inline-block; width: 4em;">&nbsp;未記入</span>';
  } else {
    return `<span style="background-color: yellow">${text}</span>`;
  }
}

export function experienceTemplate(name, address, product) {
  return `<span style="color: blue">地域住民の皆様、こんにちは！<br/>
${applyYellowMarker(address)}にある${applyYellowMarker(name)}では、地域の皆様向けに楽しい農業体験を提供しております。ぜひご参加ください！<br/>
${applyYellowMarker(name)}での農業体験は、地域の方々同士の交流や、新たな友達づくりにもぴったりです。<br/>
${applyYellowMarker(product)}などの収穫体験や畑作業体験を通して、地域の皆様と一緒に手を取り合って農業に取り組んで行きたいと思っています。<br/>
また、農業体験を通じて地域の農業に興味を持っていただけることで、将来的には地域の農業振興にもつながることを期待しております。</br>
${applyYellowMarker(name)}での農業体験は、地域の皆様にとって新鮮な体験や癒しの場となることでしょう。</br>
美しい自然に囲まれた当農園で、皆さんの笑顔に出会えることを楽しみにしております。お気軽にお越しください！</br>
ご質問や体験の予約など、お気軽にメッセージをお送りください！</span>`
;
}