function applyYellowMarker(text) {
  if (text.trim() === '') {
    return '<span style="background-color: #FF8C94; display: inline-block; width: 4em;">&nbsp;未記入</span>';
  } else {
    return `<span style="background-color: yellow">${text}</span>`;
  }
}

export function profileTemplate(name, address, product) {
  return `<span style="color: blue">${applyYellowMarker(address)}に位置する${applyYellowMarker(name)}は、緑豊かな環境で地域住民の皆様に愛される農家を目指しております。</br>
私たちは、${applyYellowMarker(product)}を主に栽培し、安全で美味しい作物を皆様にお届けしています。当農園では、環境に配慮した持続可能な農業を実践し、健全な土壌と生態系を保つよう努力しております。また、農業に興味がある方や地域の皆様を対象に、農業体験などを開催しています。四季折々の風景を楽しみながら、新鮮で栄養豊富な農作物を収穫する喜びを体験していただけます。ご家族やお友達と一緒に農業の魅力を発見し、心身のリフレッシュや地域とのつながりを深めましょう。ご質問やお問い合わせがございましたら、お気軽にメッセージをお送りください。皆様からのメッセージを心よりお待ちしております！</span>`
;
}