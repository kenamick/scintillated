package main

import (
	"image/color"

	"github.com/ebitengine/debugui"
	"github.com/hajimehoshi/ebiten/v2"
)

type Game struct {
	debugui debugui.DebugUI

	screenWidth  int
	screenHeight int

	board *Board
}

func (g *Game) Init() {
	g.board = &Board{
		LineWidth: 10,
		DotRadius: 8,
		cellWidth: 40,
	}
}

func (g *Game) Layout(outsideWidth, outsideHeight int) (screenWidth, screenHeight int) {
	return g.screenWidth, g.screenHeight
}

func (g *Game) Update() error {
	return nil
}

func (g *Game) Draw(screen *ebiten.Image) {
	screen.Fill(color.RGBA{0, 91, 114, 0})

	g.board.Draw(screen)
	g.debugui.Draw(screen)
}
