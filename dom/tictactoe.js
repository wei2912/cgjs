!function(){function r(r){for(var t=Array(r),i=0;r>i;++i){for(var e=Array(r),o=0;r>o;++o)e[o]=null;t[i]=e}return t}function t(r){switch(r){case"X":return"O";case"O":return"X"}}function i(){this.grid=r(3)}i.prototype.grid=null,i.prototype.gridSize=3,i.prototype.curPlayer="X",i.prototype.gameState=null,i.prototype.move=function(r,i){if(0>r||r>=this.gridSize||0>i||i>=this.gridSize)throw new RangeError("Cell is out of range.");if(null!=this.grid[r][i])throw new Error("Square is already occupied.");this.grid[r][i]=this.curPlayer,this.isWin()?this.gameState=this.curPlayer:this.isDraw()&&(this.gameState="draw"),this.curPlayer=t(this.curPlayer)},i.prototype.getWinSeqs=function(){for(var t=this.grid,i=this.gridSize,e=Array(i),o=0;i>o;++o)e[o]=t[o].slice();var n=r(i);for(o=0;i>o;++o)for(var a=0;i>a;++a)n[o][a]=t[a][o];var s=Array(i);for(o=0;i>o;++o)s[o]=t[o][i-o-1];var u=Array(i);for(o=0;i>o;++o)u[o]=t[o][o];return e.concat(n).concat([s,u])},i.prototype.isWin=function(){var r=this.getWinSeqs();r:for(var t=0;t<r.length;++t){for(var i=r[t],e=0;e<i.length-1;++e)if(null==i[e]||i[e]!=i[e+1])continue r;return!0}return!1},i.prototype.isDraw=function(){for(var r=0;r<this.gridSize;++r)for(var t=0;t<this.gridSize;++t)if(null==this.grid[r][t])return!1;return!this.isWin()},window.TicTacToe=i}();
