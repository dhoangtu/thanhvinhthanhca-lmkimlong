% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tạ Ơn Chân Thành" }
  composer = "Tv. 74"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 d4 |
  b'4. b8 |
  a8. a16 e (g) e8 |
  d4 d8 d |
  b'4. c16 (b) |
  a2 ~ |
  a4 a8 g |
  fs4. fs8 |
  g g a e |
  d4 d8 d |
  a'4. a8 |
  g2 ~ |
  g4 r \bar "||" \break
  
  g8. g16 a8 b |
  e,4. fs8 |
  g e d16 (e) a8 |
  a4 r8 g |
  c c16 b b8 a16 (c) |
  d4. b8 |
  c c16 e, a8 b16 (a) |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d4 |
  g4. g8 |
  d8. d16 e (g) e8 |
  d4 d8 d |
  g4. a16 (g) |
  d2 ~ |
  d4 cs8 cs |
  d4. ds8 |
  e e c c |
  b4 b8 b |
  c4. d8 |
  b2 ~ |
  b4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa, chúng con xin cảm tạ Ngài
  và cầu khấn Thánh Danh.
  Xin kể lại kỳ công tay Chúa đã làm
  và tạ ơn chân thành.
  <<
    {
      \set stanza = "1."
      Vào thời Ta ấn định,
      Ta sẽ phân xử công minh,
      Mặt đất với dân cư chuyển rung,
      Ta sẽ đóng trụ cho vững bền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này bọn kiêu hãnh này,
	    thôi chớ ngạo ngược dương oai,
	    Và nói với bao quân tội lỗi
	    thôi chớ táo bạo khinh Chúa Trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì này ta Chúa cầm đong ắp ly rượu chua cay,
	    Và bắt lũ gian manh phải uống;
	    mau uống hết cặn không chút thừa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dạo đàn lên hát mừng,
	    tôi sẽ muôn thuở hân hoan,
	    Và sẽ phá tan uy kẻ dữ,
	    tôn vững thế lực bao kẻ lành.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
