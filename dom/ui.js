!function(){function e(e){var t=document.querySelectorAll(e);return 1==t.length?t[0]:t}var t={};t.defaultPlayer="X",t.start=function(){t.initElems(),t.game=new TicTacToe,t.createGrid(),t.setStatus("Click here to start."),t.addListener(t.onCellSelected)},t.initElems=function(){t.elems={playerX:e("#player-x"),playerO:e("#player-o"),status:e("#status"),grid:e("#grid")},t.elems["player"+t.defaultPlayer].classList.add("selected");var a=t.elems.status;a.addEventListener("click",function(){a.classList.remove("active")},!1)},t.createGrid=function(){for(var a="",r=0;r<t.game.gridSize;++r){a+="<tr>";for(var s=0;s<t.game.gridSize;++s)a+="<td></td>";a+="</tr>"}t.elems.grid.innerHTML=a,t.elems.cells=e("#grid td")},t.addListener=function(e){for(var a=t.elems.cells,r=0,s=a.length;s>r;++r)!function(t){a[t].addEventListener("click",function(){e(t)},!1)}(r)},t.setStatus=function(e){var a=t.elems.status;a.innerHTML=e,a.classList.add("active")},t.gameOver=function(e,a){var r;"win"==e?r=a+" has won!":"draw"==e&&(r="It’s a draw.");var s=t.elems.status;s.addEventListener("click",function(){location.reload()},!1),t.setStatus(r)},t.onCellSelected=function(e){var a=t.game,r=Math.floor(e/a.gridSize),s=e%a.gridSize;try{a.move(r,s),t.render(),"X"==a.gameState||"O"==a.gameState?t.gameOver("win",a.gameState):"draw"==a.gameState&&t.gameOver(a.gameState)}catch(l){t.setStatus(l)}},t.render=function(){for(var e=t.game,a=t.game.grid,r=t.elems.cells,s=0;s<a.length;++s)for(var l=a[s],i=0;i<l.length;++i){var n=l[i];if(null!=n){var c=s*e.gridSize+i,d="player-"+n.toLowerCase();r[c].className=d,r[c].innerHTML=n}}var o=e.curPlayer,m="X"==o?"O":"X";t.elems["player"+o].classList.add("selected"),t.elems["player"+m].classList.remove("selected")},window.ui=t}();
