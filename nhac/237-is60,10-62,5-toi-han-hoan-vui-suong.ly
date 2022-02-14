% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tôi Hân Hoan Vui Sướng" }
  composer = "Is. 60,10-62,5"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8. a16 a8 a |
  bf2 |
  g4. g8 |
  a2 |
  f8. g16 e8 d |
  c4 a'8 f |
  bf4. a8 |
  g4 r8 e |
  e8. g16 g8 g |
  a d,4 c8 |
  g'8. g16 bf8 a |
  g4 r8 c16 d |
  bf8 bf g bf |
  a4 r8 g16 g |
  g8 c, g' e |
  f2 \bar "||"
  
  g8. a16 d,8 g ~ |
  g g d e16 (d) |
  c2 |
  f8.
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1.6
      \parenthesize
      g8
    }
  >>
  \oneVoice
  a ~ |
  a c d, d16 (f) |
  g4 r8 bf |
  bf8. bf16 g8
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      a8
    }
  >>
  \oneVoice
  a4. bf8 |
  c4 r8 g16 g |
  a8
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-2.7
      \tweak font-size #-2
      \parenthesize
      a16
      \once \override NoteColumn.force-hshift = #0.5
      %\tweak font-size #-2
      \parenthesize
      a16
    }
  >>
  \oneVoice
  e8 g |
  c,4 g'8 e |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. f16 f8 e |
  d2 |
  e4. e8 |
  f2 |
  f8. g16 e8 d |
  c4 f8 d |
  g4. f8 |
  c4 r8 e |
  e8. g16 g8 g |
  a d,4 c8 |
  f8. f16 g8 f |
  e4 r8 a16 bf |
  g8 g e g |
  f4 r8 bf,16 bf |
  c8 a bf c |
  a2 |
  
  g'8. a16 d,8 g ~ |
  g g d e16 (d) |
  c2 |
  f8.
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1.6
      \parenthesize
      g8
    }
  >>
  \oneVoice
  a ~ |
  a c d, d16 (f) |
  g4 r8 g |
  g8. g16 e8
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f8
    }
  >>
  \oneVoice
  f4. g8 |
  a4 r8 e16 e |
  f8
  <<
    {
      \voiceOne
      f8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \once \override NoteColumn.force-hshift = #-2.7
      \tweak font-size #-2
      \parenthesize
      f16
      \once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \once \override NoteColumn.force-hshift = #0.5
      \tweak font-size #-2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  d8 bf |
  a4 bf8 c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Tôi hân hoan vui sướng trong Thiên Chúa,
  Trong Đấng tôi tôn thờ,
  tôi mừng rỡ biết bao.
  Ngài mặc cho tôi ơn cứu độ,
  choàng cho tôi đức công minh
  Như chú rể chỉnh tề áo khăn,
  Như cô dâu lộng lẫy điểm trang.
  <<
    {
      \set stanza = "1."
      Như đất làm cho đâm chồi nảy lộc,
      Như vườn tược khiến nhú mầm trổ cây,
      Chúa cũng sẽ làm trổ hoa công chính,
      Làm trổi vang muôn lời ca ngợi trước ngàn dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vì mến Si -- on tôi chẳng nín lặng,
	    Bởi chuộng \markup { \italic \underline "Gia" }
	    -- liêm lẽ nào ngủ yên
	    Tới lúc Đấng tựa hừng đông hiện đến,
	    Tựa ngọn đuốc \markup { \italic \underline "Đấng Cứu" } Độ
	    của thành sáng rực lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Muôn nước nhìn coi ngươi thực chính trực,
	    Bao vị hoàng đế ngắm hiển vinh ngươi
	    Khắp chốn sẽ gọi
	    \markup { \italic \underline "ngươi" } bằng tên mới,
	    thực là chính tên miệng Chúa Trời đã đặt cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Người sẽ trở nên mũ triều thiên vàng,
	    như ngọc miện quý Chúa cầm ở ta.
	    Quê ngươi sẽ chẳng còn là nơi hoang vắng,
	    Và chẳng sẽ ai gọi ngươi là ''thứ bỏ đi''.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngươi sẽ được kêu: ''Ái khanh Ta này'',
	    Quê \markup { \italic \underline "ngươi" }
	    được tiếng ''đất đà đẹp duyên''.
	    Chúa sẽ ái mộ và thương ngươi mãi
	    Và sẽ kết ước tình yêu cùng xứ sở ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào khác tài trai cưới tôn nữ về:
	    Đấng tạo thành ngươi kết bạn cùng ngươi.
	    Như tân nương làm tình quân vui sướng,
	    thì này ngươi cũng làm thỏa lòng Chúa Trời ngươi.
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
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
