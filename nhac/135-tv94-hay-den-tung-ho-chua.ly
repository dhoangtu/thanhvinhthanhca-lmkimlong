% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Đến Tung Hô Chúa" }
  composer = "Tv. 94"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 d8 d |
  b4 c8 c |
  a8. a16 a8 a |
  b4 g8 e |
  e4. d8 |
  b' b g g |
  a2 |
  r8 g e' e |
  c4 d8 d |
  b b a d |
  fs,4 g8 g |
  e4. d8 |
  a' a fs fs |
  g2 ~ |
  g4 r8 \bar "||"
  
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2.5
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  g8. g16 b (c) b8 |
  a4. fs8 |
  g8. a16 e (g) e8 |
  d4 r8 b16 d |
  g8 fs b16 (c) b8 |
  a4. fs16 a |
  g8 e fs e |
  d4 r8 d |
  g e16 e e8 e |
  e c'4 a8 |
  b4 r8 g |
  g g16 g c8 a |
  d d4 d8 |
  g,4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  b8 b |
  g4 a8 a |
  fs8. fs16 fs8 fs |
  g4 e8 d |
  cs4. d8 |
  g g e e |
  d2 |
  r8 g c c |
  a4 b8 b |
  g g fs e |
  d4 e8 d |
  c4. b8 |
  c c d d |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy đến đây cất tiếng ca,
  ta tung hô Chúa,
  Reo mừng Ngài là núi đá độ trì ta.
  Vào trước Thánh Nhan,
  hãy xướng lên muôn lời cảm tạ,
  Tung hô Ngài cùng với tiếng đàn lời ca.
  <<
    {
      \set stanza = "1."
      Vì Ngài là Chúa cao quang,
      Đại vương trổi vượt chư thần,
      Mọi vực sâu Ngài nắm trong tay,
      Mọi đỉnh cao Ngài giữ chủ quyền.
      Đại dương là của Ngài
      vì Ngài đã dựng nên,
      Lục địa thuộc về Chúa
      vì Chúa đã tác thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    \markup { \italic \underline "Hãy" }
	    vào phục bái suy tôn,
	    Quỳ đây trước thánh nhan Ngài,
	    Vì Ngài đà tạo tác nên ta,
	    Ngài vẫn luôn là Chúa ta thờ,
	    Còn ta là dòng tộc được Ngài thống trị luôn,
	    Cùng thuộc về đàn chiên mà Chúa vẫn dắt dìu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hôm nay nghe tiếng Chúa đi,
	    Lòng thôi cứng cỏi vô nghì,
	    Đừng như khi tại Mê -- ri -- ba,
	    Tại Mas -- sa, ở giữa sa mạc,
	    Tổ tiên họ đà từng nhiều lần dám thử Ta,
	    Dù rằng sự việc Ta họ chứng kiến rõ ràng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Miệt mài đà bốn mươi năm,
	    Làm Ta ngán ngẩm dân này,
	    Một đoàn dân lầm lỗi phiêu linh,
	    Đường lối Ta chẳng biết theo đòi,
	    Vậy Ta từng thịnh nộ thề rằng:
	    chúng đừng trông
	    Được vào mà nghỉ ngơi ở đất hứa phúc lộc.
    }
  >>
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key g \major \time 2/4
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
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
