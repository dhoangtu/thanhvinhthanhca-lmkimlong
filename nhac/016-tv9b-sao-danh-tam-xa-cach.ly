% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Sao Đành Tâm Xa Cách" }
  composer = "Tv. 9B"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  b4. a8 |
  gs a4 b8 |
  c2 ~ |
  c8 b d d |
  e4. b8 |
  c8. b16 gs8 e |
  a2 ~ |
  a4 \bar "||" \break
  
  e8. e16 |
  a8 d,4 d8 |
  c8. b16 d8
  <<
    {
      \voiceOne
      d
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2.1
      \once \tiny
      \parenthesize e
    }
  >>
  \oneVoice
  e2 ~ |
  e4 e8. e16 |
  b'8 c4 c8 |
  e8. f16 b,8 c |
  a2 ~ |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 |
  e4. c8 |
  e f4 e8 |
  a2 ~ |
  a8 e b' a |
  gs4. gs8 |
  a8. d,16 e8 d |
  c2 ~ |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa ơi, sao đành tâm xa cách,
  ngày con nguy khốn sao nỡ ngoảnh mặt làm ngơ.
  <<
    {
      \set stanza = "1."
      Này người khó nghèo luôn bị địch quân uy hiếp
      Còn bọn kiêu hãnh ngạo nghễ xúc phạm đến Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bọn họ nói rằng: ta sợ gì, đâu
	    \markup { \italic \underline "có" }
	    Chúa,
	    Việc họ toan tính thực phán quyết Ngài xa vời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Địch thù nhủ thầm:
	    ta chẳng hề chi nao núng,
	    Trọn đời ta đấy chẳng có lúc nào khốn cùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Miệng họ rủa nguyền, lưỡi gian tà gây tai biến,
	    Phục cạnh thôn ấp, rình bắt giết người vô tội.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Họ từng nhủ lòng:
	    Chúa đâu còn lưu tâm nữa,
	    Ngài đà che mắt nào có thấy chi nữa mà.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nguyện Ngài chỗi dậy, sao bỏ người lâm nguy khốn,
	    Kìa bọn gian ác cả dám xúc phạm đến Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Người nghèo khấn cầu,
	    mong Ngài thuận cho như ý,
	    Nhờ Ngài bên đỡ họ mãi vững dạ an lòng.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
