% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lòng Con Yêu Mến Chúa" }
  composer = "Tv. 114"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8. a16 a8 b |
  c4. a8 |
  e'8. e16 f8 e |
  c d ~ d4 |
  c8. c16 d8 e |
  b4. e,8 |
  c'8. b16 c8 c |
  b a ~ a4 \bar "||"
  
  a8. f16 e8 b |
  e b'4 c8 |
  c2 |
  f8. e16 e8 c |
  e
  \afterGrace c4 ({
    \override Flag.stroke-style = #"grace"
    b16)}
  \revert Flag.stroke-style
  a8 |
  b2 |
  a8. a16 a8 f |
  e8. b'16 b8 b |
  c4. b16 a |
  e'4. d8 |
  c e
  \once \phrasingSlurDashed
  e, \(g\) |
  a2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8. a16 a8 b |
  c4. a8 |
  c8. c16 d8 c |
  a b ~ b4 |
  a8. a16 b8 a |
  gs4. e8 |
  a8. gs16 a8 e |
  d c ~ c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lòng con yêu mến Chúa,
  vì Chúa nghe tiếng con nài van.
  Vào ngày con khấn cầu,
  Ngài đã ưu ái lắng tai nghe.
  <<
    {
      \set stanza = "1."
      Giây tử thần chằng chịt giăng tứ phía,
      Lưới âm ty chụp xuống trên mình tôi.
      Trong gian nan khổ sầu
      tôi kêu Danh Chúa,
      Ôi lạy Chúa xin Ngài cứu mạng _ con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa nhân hậu ngàn đời luôn tín nghĩa,
	    Chúa ta đây hằng trắc ẩn từ tâm
	    Luôn yêu thương giữ gìn cho ai thơ bé,
	    Tôi hèn yếu đây Ngài cứu độ _ cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cứu mạng này khỏi chìm trong cõi chết,
	    Mắt tôi nay khỏi đẫm lệ sầu thương
	    Nơi tôn nhan của ngài cho tôi đi tới,
	    Không hụt bước trong miền đất
	    \markup { \italic \underline "của" }
	    \markup { \italic \underline "nhân" }
	    sinh.
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
