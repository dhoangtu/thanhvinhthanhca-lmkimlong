% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Mừng Chúc Thánh Quân" }
  composer = "Tv. 44"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 c |
  e f16 (e) d8 d16 (e) |
  g4 d'8 d |
  d8. b16 d8 d |
  c4 e16 (f) e8 |
  a,8. d16 d (e) d8 |
  g,2 ~ |
  g4 e8 g |
  d' d4 b8 |
  c4 d8 b |
  b8. c16 a (c) a8 |
  g4 r8 g16 g |
  d'8. d16 b8 b |
  c2 ~ |
  c4 \bar "||"
  
  g8 g |
  e2 ~ |
  e8 c' c a |
  a4 a8 f |
  d2 ~ |
  d8 c b g' |
  g2 |
  r8 c d e |
  a,8. a16 d8 c |
  g4 g8 g |
  a a a f |
  d8. d16 g8 g |
  c,4 e8 e |
  d8. a'16 fs8 fs |
  g4 \bar "|"
}

nhacPhienKhucAlto = \relative c' {
  c8 c |
  e f16 (e) d8 d16 (e) |
  g4 f8 fs |
  g8. g16 g8 g |
  e4 g8 [g] |
  fs8. fs16 f!8 [f] |
  e8. d16 e8 c |
  b4 c8 e |
  f g4 g8 |
  a4 fs8 fs |
  g8. a16 f8 [f] |
  e4 r8 e16 e |
  f8. f16 g8 g |
  e2 ~ |
  e4
  
  g8 g |
  e2 ~ |
  e8 c' c a |
  a4 a8 f |
  d2 ~ |
  d8 c b g' |
  g2 |
  r8 e g g |
  f8. f16 f8 f |
  e4 e8 e |
  f f f d |
  c8. c16 b8 b |
  c4 c8 c |
  b8. c16 d8 d |
  b4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lòng trào dâng những lời cẩm tú,
  Tôi ngâm thơ mừng chúc thánh quân,
  Lưỡi tôi tựa tay bút điêu luyện
  Ngài tuyệt mỹ giữa phàm nhân,
  nét duyên tươi thắm nở môi miệng,
  Ngài được Chúa chúc lành ngàn năm.
  <<
    {
      \set stanza = "1."
      Cung ngai Ngài thiên niên vạn đại,
      phủ việt Ngài vương trượng công minh,
      Ngài yêu thích trực và ghét gian tà
      Nên Thiên Cháu đã xức cho Ngài
      dầu thơm hoan lạc,
      Tôn phong Ngài trổi vượt đồng liêu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đeo bên mình lưỡi kiếm oai phong,
	    cỡi ngựa hồng lẫm liệt đi lên,
	    Ngài yêu lẽ thật và đức công bình,
	    Gieo kinh hãi với mũi tên nhọn,
	    thần dân suy phục,
	    Bao quân thù ngã gục tàn vong.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đây long bào thắm ngát hương thơm,
	    cung nhạc vàng thỏa lòng quân vương,
	    Này công chúa và kiều nữ cung điện,
	    Ngay bên hữu có thái phi Ngài
	    kề vai xinh đẹp,
	    Luôn trang điểm với toàn vàng y.
    }
  >>
}

loiPhienKhucAlto = \lyrics {
  \repeat unfold 21 { _ }
  \override Lyrics.LyricText.font-shape = #'italic
  tay bút điêu luyện
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      \new NullVoice = beAlto \nhacPhienKhucAlto
      \new Lyrics \lyricsto beAlto \loiPhienKhucAlto
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
